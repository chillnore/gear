package gear.gui.containers {
	import gear.gui.core.GAlignLayout;
	import gear.gui.core.GBase;
	import gear.gui.core.GScaleMode;
	import gear.gui.skin.IGSkin;
	import gear.gui.utils.GUIUtil;
	import gear.log4a.GLogger;

	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * 面板控件
	 * 
	 * @author bright
	 * @version 20121204
	 */
	public class GPanel extends GBase {
		protected var _bgSkin : IGSkin;
		protected var _content : Sprite;
		protected var _modalSkin : Sprite;
		protected var _onClose : Function;

		override protected function preinit() : void {
			_bgSkin = GUIUtil.theme.panelBgSkin;
			setSize(100, 100);
		}

		override protected function create() : void {
			_bgSkin.addTo(this, 0);
			_content = new Sprite();
			_content.name = "content";
			addChild(_content);
		}

		override protected function resize() : void {
			_bgSkin.setSize(_width, _height);
			var base : DisplayObject;
			for (var i : int = 0;i < _content.numChildren;i++) {
				base = _content.getChildAt(i);
				GAlignLayout.layout(base);
			}
		}

		/**
		 * @private
		 */
		override protected function onHide() : void {
			if (_modalSkin != null) {
				_modalSkin.parent.removeChild(_modalSkin);
			}
			if (_onClose != null) {
				try {
					_onClose();
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
		}

		override protected function onStageResize() : void {
			addRender(showModal);
		}

		protected function showModal() : void {
			if (_modalSkin != null) {
				_modalSkin.width = GUIUtil.root.stage.stageWidth;
				_modalSkin.height = GUIUtil.root.stage.stageHeight;
				GUIUtil.root.stage.focus = null;
				_modalSkin.width = GUIUtil.root.stage.stageWidth;
				_modalSkin.height = GUIUtil.root.stage.stageHeight;
				parent.addChildAt(_modalSkin, parent.numChildren - 1);
				parent.setChildIndex(this, parent.numChildren - 1);
			}
		}

		public function GPanel() {
		}

		public function set bgSkin(value : IGSkin) : void {
			if (_bgSkin == value) {
				return;
			}
			if (_bgSkin != null) {
				_bgSkin.remove();
			}
			_bgSkin = value;
			if (_bgSkin == null) {
			}
			_bgSkin.addTo(this);
			if (_scaleMode == GScaleMode.FIT_SIZE) {
				forceSize(_bgSkin.width, _bgSkin.height);
			}
		}

		/**
		 * 设置模式
		 */
		public function set modal(value : Boolean) : void {
			if ((_modalSkin != null) == value) {
				return;
			}
			if (value) {
				// _modalSkin = GUIUtil.theme.modalSkin;
				addRender(showModal);
			} else {
				if (_modalSkin != null && _modalSkin.parent != null) {
					_modalSkin.parent.removeChild(_modalSkin);
				}
				_modalSkin = null;
			}
		}

		public function add(value : GBase) : void {
			if (value == null) {
				return;
			}
			_content.addChild(value);
		}
		
		public function set onClose(value:Function):void{
			_onClose=value;
		}
	}
}
