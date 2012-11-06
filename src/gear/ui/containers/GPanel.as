package gear.ui.containers {
	import gear.ui.core.GBase;
	import gear.ui.core.GScaleMode;
	import gear.ui.data.GPanelData;
	import gear.ui.layout.GLayout;
	import gear.ui.manager.GUIUtil;
	import gear.ui.skin.ASSkin;
	import gear.utils.MathUtil;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * 面板控件
	 * 
	 * @author bright
	 * @version 20121105
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
		protected var _viewRect : Rectangle = new Rectangle();
		protected var _bounds : Rectangle = new Rectangle();

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
				case GScaleMode.WIDTH_ONLY:
					_height = _data.bgSkin.height;
					break;
				case GScaleMode.NONE:
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
			_viewW = Math.max(_base.minWidth, _width - _data.padding * 2);
			_viewH = Math.max(_base.minHeight, _height - _data.padding * 2);
			_viewRect.width = _viewW;
			_viewRect.height = _viewW;
			_content.scrollRect = _viewRect;
		}

		protected function resetBounds() : void {
			var total : int = _content.numChildren;
			var x : Number = 0;
			var y : Number = 0;
			var w : Number = _base.minWidth;
			var h : Number = _base.minHeight;
			for (var i : int = 0;i < total;i++) {
				var child : DisplayObject = _content.getChildAt(i);
				x = Math.min(x, child.x);
				y = Math.min(y, child.y);
				w = Math.max(w, child.x + child.width);
				h = Math.max(h, child.y + child.height);
			}
			_bounds = new Rectangle(x, y, w, h);
		}
		
		/**
		 * @private
		 */
		override protected  function onShow() : void {
			if (_data.modal) {
				GUIUtil.root.stage.focus = null;
				var topLeft : Point = parent.localToGlobal(MathUtil.ZERO_POINT);
				_modalSkin.x = -topLeft.x;
				_modalSkin.y = -topLeft.y;
				_modalSkin.width = GUIUtil.root.stage.stageWidth;
				_modalSkin.height = GUIUtil.root.stage.stageHeight;
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
			var hitTarget : DisplayObject = GUIUtil.hitTest(stage.mouseX, stage.mouseY);
			if (!GUIUtil.atParent(hitTarget, this)) {
				var outside : Boolean = true;
				if (GUIUtil.atParent(hitTarget, _menuTrigger)) {
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
