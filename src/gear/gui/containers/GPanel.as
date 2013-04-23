package gear.gui.containers {
	import gear.gui.core.GAlignLayout;
	import gear.gui.core.GBase;
	import gear.gui.core.GPhase;
	import gear.gui.core.GScaleMode;
	import gear.gui.skins.GPanelSkin;
	import gear.gui.skins.IGSkin;
	import gear.gui.utils.GUIUtil;
	import gear.log4a.GLogger;
	import gear.utils.GMathUtil;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * 面板控件
	 * 
	 * @author bright
	 * @version 20130116
	 */
	public class GPanel extends GBase {
		protected var _bgSkin : IGSkin;
		protected var _content : Sprite;
		protected var _modalSkin : IGSkin;
		protected var _modal : Boolean;
		protected var _onClose : Function;

		override protected function preinit() : void {
			_bgSkin = GPanelSkin.skin;
			_modalSkin = GPanelSkin.modalSkin;
			_modal = false;
			setSize(100, 100);
		}

		override protected function create() : void {
			_bgSkin.addTo(this, 0);
			_content = new Sprite();
			_content.name = "content";
			addChild(_content);
		}

		override protected function resize() : void {
			if (_bgSkin != null) {
				_bgSkin.setSize(_width, _height);
			}
			var base : DisplayObject;
			for (var i : int = 0; i < _content.numChildren; i++) {
				base = _content.getChildAt(i);
				GAlignLayout.layout(base);
			}
		}

		override protected function onShow() : void {
			if (_modal) {
				callLater(changeModal);
			}
		}

		/**
		 * @private
		 */
		override protected function onHide() : void {
			_modalSkin.remove();
			if (_onClose != null) {
				try {
					_onClose();
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
		}

		override protected function onStageResize() : void {
			if (_modal) {
				callLater(changeModal);
			}
		}

		protected function changeModal() : void {
			var topLeft : Point = parent.localToGlobal(GMathUtil.ZERO_POINT);
			_modalSkin.moveTo(-topLeft.x, -topLeft.y);
			_modalSkin.setSize(GUIUtil.stage.stageWidth, GUIUtil.stage.stageHeight);
			_modalSkin.addTo(parent, parent.numChildren - 1);
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
				return;
			}
			_bgSkin.phase = (_enabled ? GPhase.UP : GPhase.DISABLED);
			_bgSkin.addTo(this, 0);
			if (_scaleMode == GScaleMode.FIT_SIZE) {
				forceSize(_bgSkin.width, _bgSkin.height);
			}
		}

		/**
		 * 设置模式
		 */
		public function set modal(value : Boolean) : void {
			if (_modal == value) {
				return;
			}
			_modal = value;
			callLater(changeModal);
		}

		public function add(value : GBase) : void {
			if (value == null) {
				return;
			}
			_content.addChild(value);
		}

		public function set onClose(value : Function) : void {
			_onClose = value;
		}
	}
}
