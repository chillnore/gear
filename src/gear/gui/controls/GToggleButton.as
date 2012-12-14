package gear.gui.controls {
	import gear.gui.core.GAlign;
	import gear.gui.core.GAlignLayout;
	import gear.gui.core.GAutoSizeMode;
	import gear.gui.core.GScaleMode;
	import gear.gui.skin.IGSkin;
	import gear.gui.utils.GUIUtil;

	import flash.display.BitmapData;

	/**
	 * 按钮控件
	 * 
	 * @author bright
	 * @version 20121204
	 */
	public class GToggleButton extends GToggleBase {
		protected var _skin : IGSkin;
		protected var _label : GLabel;

		override protected function preinit() : void {
			_padding.hdist = 6;
			_padding.vdist = 4;
			_skin=GUIUtil.theme.toggleButtonSkin;
			setSize(60, 22);
		}

		override protected function create() : void {
			_skin.addTo(this);
			_label = new GLabel();
			_label.align = GAlign.CENTER;
			addChild(_label);
		}

		override protected function resize() : void {
			trace("resize", name,_phase,_width,_height);
			_skin.setSize(_width, _height);
			_skin.phase = _phase;
		}

		protected function update() : void {
			trace("update", name);
			if (_autoSize == GAutoSizeMode.AUTO_SIZE) {
				forceSize(_padding.left + _label.width + _padding.right, _padding.top + _label.height + _padding.bottom);
			} else if (_autoSize == GAutoSizeMode.AUTO_WIDTH) {
				forceSize(_padding.left + _label.width + _padding.right, _height);
			}
			GAlignLayout.layout(_label);
		}
		
		override protected function viewSkin() : void {
			trace("viewSkin", name);
			_label.phase = _phase;
			_skin.phase = _phase;
		}

		override protected function onSelect() : void {
			_skin.selected=_selected;
			addRender(viewSkin);
		}

		public function GToggleButton() {
		}

		public function set skin(value : IGSkin) : void {
			if (_skin == value) {
				return;
			}
			if (_skin != null) {
				_skin.remove();
			}
			_skin = value;
			_skin.addTo(this);
			if (_scaleMode == GScaleMode.FIT_SIZE) {
				forceSize(_skin.width, _skin.height);
			}else if(_scaleMode==GScaleMode.FIT_WIDTH){
				forceSize(_skin.width,_height);
			}else if(_scaleMode==GScaleMode.FIT_HEIGHT){
				forceSize(_width,_skin.height);
			}
			addRender(viewSkin);
		}
		
		public function set icon(value : BitmapData) : void {
			_label.icon = value;
			addRender(update);
		}

		public function set text(value : String) : void {
			_label.text = value;
			addRender(update);
		}
	}
}