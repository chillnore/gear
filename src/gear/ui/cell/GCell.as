package gear.ui.cell {
	import gear.log4a.GLogError;
	import gear.ui.controls.GIcon;
	import gear.ui.controls.GLabel;
	import gear.ui.core.GAlign;
	import gear.ui.core.GBase;
	import gear.ui.core.GScaleMode;
	import gear.ui.core.PhaseState;
	import gear.ui.data.GLabelData;
	import gear.ui.layout.GLayout;
	import gear.ui.manager.GUIUtil;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;


	/**
	 * 单元格控件
	 * 
	 * @author bright
	 * @version 20121105
	 */
	public class GCell extends GBase {
		/**
		 * 仅用于Grid格子控件侦听是否选中的事件
		 * @eventType gear.cell.GCell.SELECT
		 */
		public static const SELECT : String = "select";
		/**
		 * @eventType gear.cell.GSell.SINGLE_CLICK
		 */
		public static const SINGLE_CLICK : String = "singleClick";
		/**
		 * @eventType gear.cell.GSell.DOUBLE_CLICK
		 */
		public static const DOUBLE_CLICK : String = "doubleClick";
		/**
		 * @private
		 */
		protected var _data : GCellData;
		/**
		 * @private
		 */
		protected var _lockIcon : GIcon;
		/**
		 * @private
		 */
		protected var _key_lb : GLabel;
		/**
		 * @private
		 */
		protected var _selected : Boolean;
		/**
		 * @private
		 */
		protected var _timer : Timer;
		/**
		 * @private
		 */
		protected var _count : int;
		/**
		 * @private
		 */
		protected var _ctrlKey : Boolean;
		/**
		 * @private
		 */
		protected var _shiftKey : Boolean;
		/**
		 * @private
		 */
		protected var _phase : int;
		/**
		 * @private
		 */
		protected var _rollOver : Boolean;
		/**
		 * @private
		 */
		protected var _index : int;

		/**
		 * @private
		 * @inheritDoc
		 */
		override protected function create() : void {
			if (_data.skin == null) {
				throw GLogError("GCellData.skin is null!");
			}
			_data.skin.addTo(this);
			_data.skin.phase = PhaseState.UP;
			if (_data.lockIconData != null) {
				_data.lockIconData.parent = this;
				_lockIcon = new GIcon(_data.lockIconData);
			}
			addKeyLabels();
			switch(_data.scaleMode) {
				case GScaleMode.WIDTH_ONLY:
					_height = _data.skin.height;
					break;
				case GScaleMode.NONE:
					_width = _data.skin.width;
					_height = _data.skin.height;
					break;
			}
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		override protected function layout() : void {
			if (_data.scaleMode == GScaleMode.NONE) {
				GLayout.layout(_key_lb);
				return;
			}
			_data.skin.setSize(_width, _height);
			GLayout.layout(_key_lb);
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		override protected function onEnabled() : void {
			if (!_enabled && _timer.running) {
				_timer.stop();
			}
			_phase = (_enabled ? PhaseState.UP : PhaseState.DISABLED);
			viewSkin();
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		override protected function onShow() : void {
			if (_data.allowDoubleClick) {
				_count = 0;
				if (_timer.running) {
					_timer.stop();
					_timer.removeEventListener(TimerEvent.TIMER, timerHandler);
				}
				_timer.addEventListener(TimerEvent.TIMER, timerHandler);
				addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				addEventListener(MouseEvent.CLICK, clickHandler);
			} else {
				addEventListener(MouseEvent.CLICK, singleClickHandler);
			}
			addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		override protected function onHide() : void {
			if (_data.allowDoubleClick) {
				if (_timer.running) {
					_timer.stop();
					_timer.removeEventListener(TimerEvent.TIMER, timerHandler);
				}
				removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				removeEventListener(MouseEvent.CLICK, clickHandler);
			} else {
				removeEventListener(MouseEvent.CLICK, singleClickHandler);
			}
			removeEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			var reset : int = (_enabled ? PhaseState.UP : PhaseState.DISABLED);
			if (_phase != reset) {
				_phase = reset;
				viewSkin();
			}
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		protected function viewSkin() : void {
			_data.skin.phase = _phase;
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		protected function rollOverHandler(event : MouseEvent) : void {
			if (!_enabled) {
				return;
			}
			_rollOver = true;
			_phase = PhaseState.OVER;
			viewSkin();
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		protected function rollOutHandler(event : MouseEvent) : void {
			if (!_enabled) {
				return;
			}
			_rollOver = false;
			_phase = PhaseState.UP;
			viewSkin();
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		protected function mouseUpHandler(event : MouseEvent) : void {
			if (!_enabled) {
				return;
			}
			_phase = (_rollOver ? PhaseState.OVER : PhaseState.UP);
			viewSkin();
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		protected function timerHandler(event : TimerEvent) : void {
			_count = 0;
			onSingleClick();
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		protected function mouseDownHandler(event : MouseEvent) : void {
			if (!_enabled) {
				return;
			}
			if (_timer.running) {
				_timer.stop();
			}
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		protected function clickHandler(event : MouseEvent) : void {
			_ctrlKey = event.ctrlKey;
			_shiftKey = event.shiftKey;
			if (_count == 1) {
				if (_timer.running) {
					_timer.stop();
				}
				_count = 0;
				onDoubleClick();
			} else {
				_count++;
				_timer.reset();
				_timer.start();
			}
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		protected function singleClickHandler(event : MouseEvent) : void {
			_ctrlKey = event.ctrlKey;
			_shiftKey = event.shiftKey;
			onSingleClick();
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		protected function onSingleClick() : void {
			dispatchEvent(new Event(GCell.SINGLE_CLICK));
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		protected function onDoubleClick() : void {
			if (_data.allowSelect) {
				if (!_selected) {
					selected = true;
				}
			}
			dispatchEvent(new Event(GCell.DOUBLE_CLICK));
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		protected function onSelected() : void {
			// this is abstract function
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		protected function addKeyLabels() : void {
			if (_data.hotKey == null) {
				return;
			}
			var data : GLabelData = new GLabelData();
			data.text = _data.hotKey;
			data.color.upColor = 0xFFFFFF;
			data.textFieldFilters = GUIUtil.getEdgeFilters(0x000000, 0.9);
			data.align = new GAlign(-1, 0, -1, 0, -1, -1);
			_key_lb = new GLabel(data);
			addChild(_key_lb);
		}

		/**
		 * @param data 单元格控件定义
		 */
		public function GCell(data : GCellData) {
			_data = data;
			_timer = new Timer(150, 1);
			_selected = _ctrlKey = _shiftKey = _rollOver = false;
			_phase = PhaseState.UP;
			super(data);
			lock = _data.lock;
			_index = -1;
		}

		/**
		 * 设置选中状态
		 * 
		 * @param value 选中状态
		 */
		public function set selected(value : Boolean) : void {
			if (_selected == value) {
				return;
			}
			_selected = value;
			_data.skin.selected = _selected;
			onSelected();
			if (_selected) {
				dispatchEvent(new Event(GCell.SELECT));
			}
		}

		/**
		 * 获得选中状态
		 * 
		 * @return 选中状态
		 */
		public function get selected() : Boolean {
			return _selected;
		}

		/**
		 * 设置锁定
		 * 
		 * @param value 是否锁定
		 */
		public function set lock(value : Boolean) : void {
			if (value) {
				if (_lockIcon != null) {
					_lockIcon.show();
					GLayout.layout(_lockIcon);
				}
			} else {
				if (_lockIcon != null) {
					_lockIcon.hide();
				}
			}
		}

		/**
		 * @return 是否按下Ctrl键
		 */
		public function get ctrlKey() : Boolean {
			return _ctrlKey;
		}

		/**
		 * @return 是否按下Shift键
		 */
		public function get shiftKey() : Boolean {
			return _shiftKey;
		}

		/**
		 * @return 单元格控件定义
		 */
		public function get data() : GCellData {
			return _data;
		}

		/**
		 * 设置索引
		 * 
		 * @param value 索引
		 */
		public function set index(value : int) : void {
			_index = value;
		}

		/**
		 * 获得索引
		 * 
		 * @return 索引
		 */
		public function get index() : int {
			return _index;
		}

		/**
		 * 克隆
		 * 
		 * @return 单元格控件
		 */
		public function clone() : GCell {
			var cell : GCell = new GCell(_data.clone());
			cell.source = _source;
			return cell;
		}
	}
}
