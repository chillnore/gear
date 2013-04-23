package gear.gui.controls {
	import gear.gui.core.GAutoSize;
	import gear.gui.core.GBase;
	import gear.gui.core.GPhase;
	import gear.gui.skins.GCheckBoxSkin;
	import gear.gui.skins.GEmptySkin;
	import gear.gui.skins.IGSkin;

	import flash.events.MouseEvent;

	/**
	 * 复选框控件
	 * 
	 * @author bright
	 * @version 20121207
	 */
	public class GCheckBox extends GBase {
		protected var _bgSkin : IGSkin;
		protected var _icon : IGSkin;
		protected var _label : GLabel;
		protected var _phase : int;
		protected var _selected : Boolean;

		override protected function preinit() : void {
			_autoSize = GAutoSize.AUTO_SIZE;
			_sizeRender = true;
			_padding.hdist = 3;
			_padding.vdist = 2;
			_bgSkin = GEmptySkin.skin;
			_icon = GCheckBoxSkin.icon;
			callLater(change);
		}

		override protected function create() : void {
			_bgSkin.addTo(this, 0);
			_icon.addTo(this, 1);
			_label = new GLabel();
			addChild(_label);
		}

		override protected function resize() : void {
			_bgSkin.setSize(_width, _height);
			_bgSkin.phase = _phase;
			_icon.phase = _phase;
		}

		override protected  function onShow() : void {
			super.onShow();
			addEvent(this, MouseEvent.ROLL_OVER, mouseHandler);
			addEvent(this, MouseEvent.ROLL_OUT, mouseHandler);
			addEvent(this, MouseEvent.MOUSE_DOWN, mouseHandler);
			addEvent(this, MouseEvent.MOUSE_UP, mouseHandler);
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
				selected = !_selected;
			}
			callLater(viewSkin);
		}

		protected function viewSkin() : void {
			_icon.phase = _phase;
			_label.phase = _phase;
		}

		protected function onSelect() : void {
			_icon.selected = _selected;
			callLater(viewSkin);
		}

		protected function change() : void {
			if (_autoSize == GAutoSize.AUTO_SIZE) {
				forceSize(_padding.left + _icon.width + _label.width + _padding.right, _padding.top + Math.max(_icon.height, _label.height) + _padding.bottom);
				_icon.x = _padding.left;
				_icon.y = (_height - _icon.height) >> 1;
				_label.x = _icon.x + _icon.width;
				_label.y = (_height - _label.height) >> 1;
			}
		}

		public function GCheckBox() {
		}

		public function set selected(value : Boolean) : void {
			if (_selected == value) {
				return;
			}
			_selected = value;
			onSelect();
		}

		public function get selected() : Boolean {
			return _selected;
		}

		public function set text(value : String) : void {
			_label.text = value;
			callLater(change);
		}
	}
}
