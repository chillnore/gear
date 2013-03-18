package gear.gui.controls {
	import gear.gui.core.GAutoSize;
	import gear.gui.skin.IGSkin;
	import gear.gui.utils.GUIUtil;

	/**
	 * 单选按钮控件
	 * 
	 * @author bright
	 * @version 20121204
	 */
	public class GRadioButton extends GToggleBase {
		protected var _bgSkin : IGSkin;
		protected var _icon : IGSkin;
		protected var _label : GLabel;

		override protected function preinit() : void {
			_autoSize = GAutoSize.AUTO_SIZE;
			_sizeRender = true;
			_padding.hdist = 3;
			_padding.vdist = 2;
			_bgSkin = GUIUtil.theme.emptySkin;
			_icon = GUIUtil.theme.radioButtonIcon;
			addRender(updatePhase);
			addRender(updateText);
		}

		override protected function create() : void {
			_bgSkin.addTo(this, 0);
			_icon.addTo(this, 1);
			_label = new GLabel();
			addChild(_label);
		}
		
		override protected function resize():void{
			_bgSkin.setSize(_width, _height);
		}

		protected function updateText() : void {
			if (_autoSize == GAutoSize.AUTO_SIZE) {
				forceSize(_padding.left + _icon.width + _label.width + _padding.right, _padding.top + Math.max(_icon.height, _label.height) + _padding.bottom);
				_icon.x = _padding.left;
				_icon.y = (_height - _icon.height) >> 1;
				_label.x = _icon.x + _icon.width;
				_label.y = (_height - _label.height) >> 1;
				resize();
			}
		}

		override protected function updatePhase() : void {
			_icon.phase = _phase;
			_label.phase = _phase;
		}

		override protected function updateSelected() : void {
			_icon.selected = _selected;
		}

		public function GRadioButton() {
		}

		public function set text(value : String) : void {
			_label.text = value;
			addRender(updateText);
		}
	}
}
