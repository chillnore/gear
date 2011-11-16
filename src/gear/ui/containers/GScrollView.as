package gear.ui.containers {
	import gear.ui.controls.GScrollBar;
	import gear.ui.core.GBase;
	import gear.ui.data.GPanelData;
	import gear.ui.data.GScrollBarData;
	import gear.ui.events.GScrollBarEvent;
	import gear.ui.layout.GLayout;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * @author admin
	 */
	public class GScrollView extends GBase {
		/**
		 * @private
		 */
		protected var _data : GPanelData;
		protected var _content : Sprite;
		/**
		 * @private
		 */
		protected var _v_sb : GScrollBar;
		/**
		 * @private
		 */
		protected var _h_sb : GScrollBar;
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
		protected var _viewRect : Rectangle;
		protected var _bounds : Rectangle;
		protected var _menuTrigger : DisplayObject;

		override protected function create() : void {
			addChild(_data.bgSkin);
			_content = new Sprite();
			_content.name = "content";
			_content.x = _content.y = _data.padding;
			addChild(_content);
			var data : GScrollBarData = _data.scrollBarData.clone();
			data.visible = false;
			data.direction = GScrollBarData.VERTICAL;
			_v_sb = new GScrollBar(data);
			addChild(_v_sb);
			data = _data.scrollBarData.clone();
			data.direction = GScrollBarData.HORIZONTAL;
			data.visible = false;
			_h_sb = new GScrollBar(data);
			addChild(_h_sb);
			_viewRect = new Rectangle();
		}

		override protected function layout() : void {
			_data.bgSkin.width = _width;
			_data.bgSkin.height = _height;
			_viewW = Math.max(_base.minWidth, _width - _data.padding * 2);
			_viewH = Math.max(_base.minHeight, _height - _data.padding * 2);
			_viewRect.width = _viewW;
			_viewRect.height = _viewW;
			//_content.scrollRect = _viewRect;
			_v_sb.x = _width - _data.padding - _v_sb.width;
			_v_sb.y = _data.padding;
			_h_sb.x = _data.padding;
			_h_sb.y = _height - _data.padding - _h_sb.height;
			//reset();
		}

		/**
		 * @private
		 */
		protected function resetBounds() : void {
			var total : int = numChildren;
			var x : Number = 0;
			var y : Number = 0;
			var w : Number = _base.minWidth;
			var h : Number = _base.minHeight;
			for (var i : int = 0;i < total;i++) {
				var child : DisplayObject = getChildAt(i);
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
		protected function reset() : void {
			resetBounds();
			var needV : Boolean = _bounds.height > _viewH;
			var needH : Boolean = _bounds.width > _viewW;
			if (needV && !needH) {
				needH = _bounds.width > _viewW - _v_sb.width;
			}
			if (needH && !needV) {
				needV = _bounds.height > _viewH - _h_sb.height;
			}
			var newW : int = _viewW - (needV ? _v_sb.width : 0);
			var newH : int = _viewH - (needH ? _h_sb.height : 0);
			if (_viewRect.width != newW || _viewRect.height != newH) {
				_viewRect.width = newW;
				_viewRect.height = newH;
				resizeContent();
				reset();
				return;
			}
			if (needV) {
				if (!_v_sb.visible) {
					_v_sb.visible = true;
					_v_sb.addEventListener(GScrollBarEvent.SCROLL, scrollHandler);
				}
				_v_sb.height = newH;
				_v_sb.resetValue(newH, 0, _bounds.height - newH, (scrollRect ? scrollRect.y : 0));
			} else if (_v_sb.visible) {
				_v_sb.removeEventListener(GScrollBarEvent.SCROLL, scrollHandler);
				_v_sb.visible = false;
				_viewRect.y = 0;
			}
			if (needH) {
				if (!_h_sb.visible) {
					_h_sb.visible = true;
					_h_sb.addEventListener(GScrollBarEvent.SCROLL, scrollHandler);
				}
				_h_sb.width = newW;
				_h_sb.resetValue(newW, 0, _bounds.width - newW, (scrollRect ? +scrollRect.x : 0));
			} else if (_h_sb.visible) {
				_h_sb.removeEventListener(GScrollBarEvent.SCROLL, scrollHandler);
				_h_sb.visible = false;
				_viewRect.x = 0;
			}
			scrollRect = _viewRect;
		}

		/**
		 * @private
		 */
		protected function resizeContent() : void {
		}

		override protected function onShow() : void {
			addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
		}

		override protected function onHide() : void {
			addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
		}

		/**
		 * @private
		 */
		protected function scrollHandler(event : GScrollBarEvent) : void {
			if (event.direction == GScrollBarData.VERTICAL) {
				_viewRect.y = event.position;
			} else {
				_viewRect.x = event.position;
			}
			scrollRect = _viewRect;
		}

		/**
		 * @private
		 */
		protected function mouseWheelHandler(event : MouseEvent) : void {
			if (_v_sb && _v_sb.visible) {
				event.stopPropagation();
				_v_sb.scroll(event.delta);
			}
		}

		public function GScrollView(data : GPanelData) {
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

		public function set menuTrigger(value : DisplayObject) : void {
			_menuTrigger = value;
		}
	}
}
