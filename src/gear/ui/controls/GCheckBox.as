package gear.ui.controls {
	import gear.ui.core.GBase;
	import gear.ui.data.GCheckBoxData;
	import gear.ui.data.GIconData;
	import gear.ui.manager.UIManager;
	import gear.utils.BDUtil;

	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * 复选框控件
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class GCheckBox extends GBase {
		/**
		 * @private
		 */
		protected var _data : GCheckBoxData;
		/**
		 * @private
		 */
		protected var _upSkin : Sprite;
		/**
		 * @private
		 */
		protected var _upIcon : BitmapData;
		/**
		 * @private
		 */
		protected var _selected_upIcon : BitmapData;
		/**
		 * @private
		 */
		protected var _icon : GIcon;
		/**
		 * @private
		 */
		protected var _label : GLabel;
		/**
		 * @private
		 */
		protected var _selected : Boolean;

		/**
		 * @private
		 */
		override protected function create() : void {
			_upSkin = UIManager.getSkin(_data.upAsset);
			var data : GIconData = new GIconData();
			data.x = _data.padding;
			_icon = new GIcon(data);
			_upIcon = BDUtil.getBD(_data.upIcon);
			_selected_upIcon = BDUtil.getBD(_data.selectedUpIcon);
			_selected = _data.selected;
			_icon.bitmapData = (_selected ? _selected_upIcon : _upIcon);
			_label = new GLabel(_data.labelData);
			addChild(_upSkin);
			addChild(_icon);
			addChild(_label);
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			_label.x = _data.padding + _icon.width + _data.hGap;
			_width = _icon.width + _data.hGap + _label.width + _data.padding * 2;
			_height = Math.max(_icon.height, _label.height) + _data.padding * 2;
			_icon.y = Math.floor((_height - _icon.height) / 2);
			_label.y = Math.floor((_height - _label.height) / 2);
			_upSkin.width = _width;
			_upSkin.height = _height;
		}

		/**
		 * @private
		 */
		protected override function onShow() : void {
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}

		/**
		 * @private
		 */
		protected override function onHide() : void {
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}

		/**
		 * @private
		 */
		protected function mouseDownHandler(event : MouseEvent) : void {
			if (!_enabled){
				return;
			}
			selected = !_selected;
		}

		/**
		 * @private
		 */
		override protected function onEnabled() : void {
			_icon.gray = !_enabled;
			_label.enabled = _enabled;
		}

		/**
		 * @inheritDoc
		 */
		public function GCheckBox(data : GCheckBoxData) {
			_data = data;
			super(_data);
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
			_icon.bitmapData = _selected ? _selected_upIcon : _upIcon;
			if (_selected) {
				dispatchEvent(new Event(Event.SELECT));
			}
			dispatchEvent(new Event(Event.CHANGE));
		}

		/**
		 * 返回选中状态
		 * 
		 * @return 选中状态 
		 */
		public function get selected() : Boolean {
			return _selected;
		}
	}
}
