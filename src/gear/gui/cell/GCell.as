package gear.gui.cell {
	import gear.gui.controls.GLabel;
	import gear.gui.core.GBase;
	import gear.gui.core.GPhase;
	import gear.gui.core.GScaleMode;
	import gear.gui.skin.IGSkin;
	import gear.gui.utils.GUIUtil;
	import gear.log4a.GLogger;
	import gear.utils.GStringUtil;

	import flash.events.MouseEvent;

	/**
	 * 单元格控件
	 * 
	 * @author bright
	 * @version 20130116
	 */
	public class GCell extends GBase {
		protected var _skin : IGSkin;
		protected var _label : GLabel;
		protected var _phase : int;
		protected var _selected : Boolean;
		protected var _onClick : Function;

		override protected function preinit() : void {
			_skin = GUIUtil.theme.cellSkin;
			setSize(100, 20);
			addRender(updatePhase);
		}

		override protected function create() : void {
			_skin.addTo(this, 0);
			_label = new GLabel();
			addChild(_label);
		}

		override protected function resize() : void {
			_skin.setSize(_width, _height);
		}

		override protected function onShow() : void {
			addEvent(this, MouseEvent.ROLL_OVER, mouseHandler);
			addEvent(this, MouseEvent.ROLL_OUT, mouseHandler);
			addEvent(this, MouseEvent.MOUSE_DOWN, mouseHandler);
			addEvent(this, MouseEvent.MOUSE_UP, mouseHandler);
			addEvent(this, MouseEvent.CLICK, clickHandler);
		}

		protected function mouseHandler(event : MouseEvent) : void {
			if (!_enabled) {
				return;
			}
			if (event.type == MouseEvent.ROLL_OVER) {
				_phase = GPhase.OVER;
			} else if (event.type == MouseEvent.ROLL_OUT) {
				_phase = GPhase.UP;
			} else if (event.type == MouseEvent.MOUSE_DOWN) {
				_phase = GPhase.DOWN;
			} else if (event.type == MouseEvent.MOUSE_UP) {
				_phase = (event.currentTarget == this) ? GPhase.OVER : GPhase.UP;
			}
			addRender(updatePhase);
		}

		protected function clickHandler(event : MouseEvent) : void {
			if (_onClick == null) {
				return;
			}
			try {
				_onClick.apply(null, _onClick.length < 1 ? null : [this]);
			} catch(e : Error) {
				GLogger.error(e.getStackTrace());
			}
		}

		protected function updatePhase() : void {
			_skin.phase = _phase;
		}

		protected function updateSelected() : void {
			_skin.selected = _selected;
		}

		public function GCell() {
		}

		public function set skin(value : IGSkin) : void {
			if (value == null || _skin == value) {
				return;
			}
			if (_skin != null) {
				_skin.remove();
			}
			_skin = value;
			_skin.addTo(this);
			if (_scaleMode == GScaleMode.FIT_SIZE) {
				forceSize(_skin.width, _skin.height);
			}
			addRender(updatePhase);
		}

		public function set selected(value : Boolean) : void {
			if (_selected == value) {
				return;
			}
			_selected = value;
			addRender(updateSelected);
		}

		public function set hotKey(value : String) : void {
		}

		public function set onClick(value : Function) : void {
			_onClick = value;
		}

		override public function set source(value : *) : void {
			value = GStringUtil.toString(value);
			if (_source == value) {
				return;
			}
			_source = value;
			_label.text = _source;
		}
	}
}
