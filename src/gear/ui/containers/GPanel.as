package gear.ui.containers {
	import gear.ui.controls.GScrollBar;
	import gear.ui.core.GBase;
	import gear.ui.core.GScaleMode;
	import gear.ui.data.GPanelData;
	import gear.ui.data.GScrollBarData;
	import gear.ui.events.GScrollBarEvent;
	import gear.ui.manager.UIManager;
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
		public var _v_sb : GScrollBar;
		public var _h_sb : GScrollBar;
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
			if (_v_sb) {
				_v_sb.x = _width + 15;
				if (_width == 0) {
					_v_sb.visible = false;
				} else {
					_v_sb.visible = true;
				}
				_v_sb.y = _data.padding;
			}
			if (_h_sb) {
				_h_sb.x = _data.padding;
				_h_sb.y = _height;
			}
			resetScroll();
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

		protected function resetScroll() : void {
			var data : GScrollBarData;
			resetBounds();
			var needV : Boolean = _bounds.height > _viewH;
			var needH : Boolean = _bounds.width > _viewW;
			var newW : int = _viewW;
			var newH : int = _viewH;
			if (_viewRect.width != newW || _viewRect.height != newH) {
				_viewRect.width = newW;
				_viewRect.height = newH;
				resetScroll();
				return;
			}
			if (needV) {
				if (_v_sb == null) {
					data = _data.scrollBarData.clone();
					data.visible = false;
					data.direction = GScrollBarData.VERTICAL;
					_v_sb = new GScrollBar(data);
					_v_sb.x = _width + 15;
					addChild(_v_sb);
				}
				if (!_v_sb.visible) {
					_v_sb.visible = true;
					_v_sb.addEventListener(GScrollBarEvent.SCROLL, scrollHandler);
				}
				_v_sb.height = newH;
				_v_sb.resetValue(newH, 0, _bounds.height - newH, (_content.scrollRect ? _content.scrollRect.y : 0));
			} else if (_v_sb && _v_sb.visible) {
				_v_sb.visible = false;
				_viewRect.y = 0;
			}

			if (needH) {
				if (_h_sb == null) {
					data = _data.scrollBarData.clone();
					data.direction = GScrollBarData.HORIZONTAL;
					data.visible = false;
					_h_sb = new GScrollBar(data);
					addChild(_h_sb);
				}
				if (!_h_sb.visible) {
					_h_sb.visible = true;
					_h_sb.addEventListener(GScrollBarEvent.SCROLL, scrollHandler);
				}
				_h_sb.width = newW;
				_h_sb.resetValue(newW, 0, _bounds.width - newW, (_content.scrollRect ? +_content.scrollRect.x : 0));
			} else if (_h_sb && _h_sb.visible) {
				_h_sb.visible = false;
				_viewRect.x = 0;
			}

			_content.scrollRect = _viewRect;
		}

		protected function scrollHandler(event : GScrollBarEvent) : void {
			if (event.direction == GScrollBarData.VERTICAL) {
				_viewRect.y = event.position;
			} else {
				_viewRect.x = event.position;
			}
			_content.scrollRect = _viewRect;
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
				//GLayout.update(this, GBase(value));
			}
			resetScroll();
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
