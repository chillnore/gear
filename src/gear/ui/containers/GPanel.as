package gear.ui.containers {
	import gear.ui.core.GBase;
	import gear.ui.core.ScaleMode;
	import gear.ui.data.GPanelData;
	import gear.ui.layout.GLayout;
	import gear.ui.manager.UIManager;
	import gear.ui.skin.ASSkin;
	import gear.utils.MathUtil;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * 面板控件
	 * 
	 * @author bright
	 * @version 20101011
	 */
	public class GPanel extends GBase {
		/**
		 * @private
		 */
		protected var _data : GPanelData;
		/**
		 * @private
		 */
		protected var _content : Sprite;
		/**
		 * @private
		 */
		protected var _modalSkin : Sprite;
		/**
		 * @private
		 */
		protected var _viewW : int;
		/**
		 * @private
		 */
		protected var _viewH : int;
		/**
		 * @private
		 */
		protected var _menuTrigger : DisplayObject;
		protected var _waitTimeout : uint;

		/**
		 * @private
		 */
		override protected function create() : void {
			if (_data.bgSkin != null) {
				addChild(_data.bgSkin);
			}
			_content = new Sprite();
			_content.name = "content";
			_content.x = _content.y = _data.padding;
			addChild(_content);
			if (_data.modal) {
				_modalSkin = ASSkin.modalSkin;
			}
			switch(_data.scaleMode) {
				case ScaleMode.WIDTH_ONLY:
					_height = _data.bgSkin.height;
					break;
				case ScaleMode.NONE:
					if (_data.bgSkin != null) {
						_width = _data.bgSkin.width;
						_height = _data.bgSkin.height;
					}
					break;
				default:
					break;
			}
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			if (_data.bgSkin != null) {
				_data.bgSkin.width = _width;
				_data.bgSkin.height = _height;
			}
		}

		/**
		 * @private
		 */
		override protected  function onShow() : void {
			if (_data.modal) {
				UIManager.root.stage.focus = null;
				var topLeft : Point = parent.localToGlobal(MathUtil.ZERO_POINT);
				_modalSkin.x = -topLeft.x;
				_modalSkin.y = -topLeft.y;
				_modalSkin.width = UIManager.root.stage.stageWidth;
				_modalSkin.height = UIManager.root.stage.stageHeight;
				parent.addChildAt(_modalSkin, parent.numChildren - 1);
				parent.setChildIndex(this, parent.numChildren - 1);
			}
			if (_menuTrigger != null) {
				stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			}
		}

		/**
		 * @private
		 */
		override protected function onHide() : void {
			if (_data.modal) {
				_modalSkin.parent.removeChild(_modalSkin);
			}
			if (_menuTrigger != null) {
				stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			}
		}

		override protected function onResize() : void {
			if (_data.modal) {
				_modalSkin.width = parent.width;
				_modalSkin.height = parent.height;
			}
		}

		/**
		 * @private
		 */
		protected function stage_mouseUpHandler(event : MouseEvent) : void {
			var hitTarget : DisplayObject = UIManager.hitTest(stage.mouseX, stage.mouseY);
			if (!UIManager.atParent(hitTarget, this)) {
				var outside : Boolean = true;
				if (UIManager.atParent(hitTarget, _menuTrigger)) {
					outside = false;
				}
				if (outside) {
					hide();
				}
			}
		}

		public function GPanel(data : GPanelData) {
			_data = data;
			super(data);
		}

		public function add(value : DisplayObject) : void {
			if (value == null) {
				return;
			}
			_content.addChild(value);
			if (value is GBase) {
				GLayout.update(this, GBase(value));
			}
		}

		public function get modal() : Boolean {
			return _data.modal;
		}

		public function get padding() : int {
			return _data.padding;
		}

		public function set menuTrigger(value : DisplayObject) : void {
			_menuTrigger = value;
		}
	}
}
