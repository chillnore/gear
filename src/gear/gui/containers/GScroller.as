package gear.gui.containers {
	import gear.gui.controls.GHScrollBar;
	import gear.gui.controls.GVScrollBar;
	import gear.gui.core.GBase;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	/**
	 * @author bright
	 */
	public class GScroller extends GBase {
		protected var _vScrollBar : GVScrollBar;
		protected var _hScrollBar : GHScrollBar;
		protected var _content : Sprite;
		protected var _scrollRect : Rectangle;
		protected var _bounds : Rectangle;

		override protected function preinit() : void {
			_scrollRect = new Rectangle();
			setSize(100, 100);
		}

		override protected function create() : void {
			_content = new Sprite();
			_content.name = "content";
			addChild(_content);
			_vScrollBar = new GVScrollBar();
			_vScrollBar.visible = false;
			addChild(_vScrollBar);
			_hScrollBar = new GHScrollBar();
			_hScrollBar.visible = false;
			addChild(_hScrollBar);
		}

		override protected function resize() : void {
			_scrollRect.width = _width - _padding.left - _padding.right;
			_scrollRect.height = _height - _padding.top - _padding.bottom;
			_content.scrollRect = _scrollRect;
			_vScrollBar.x = _width - _vScrollBar.width;
			_vScrollBar.height = _height;
			_hScrollBar.y = _height - _hScrollBar.height;
			_hScrollBar.width = _width;
			callLater(changeScroll);
		}

		protected function changeBounds() : void {
			var total : int = _content.numChildren;
			var x : int = 0;
			var y : int = 0;
			var w : int = _minWidth;
			var h : int = _minHeight;
			for (var i : int = 0;i < total;i++) {
				var child : DisplayObject = _content.getChildAt(i);
				x = Math.min(x, child.x);
				y = Math.min(y, child.y);
				w = Math.max(w, child.x + child.width);
				h = Math.max(h, child.y + child.height);
			}
			_bounds = new Rectangle(x, y, w, h);
		}

		protected function changeScroll() : void {
			var vmax : int = _bounds.height - _scrollRect.height;
			var hmax : int = _bounds.width - _scrollRect.width;
			if (vmax > 0) {
				hmax += _vScrollBar.width;
			}
			if (hmax > 0) {
				vmax += _hScrollBar.height;
			}
			if (vmax > 0) {
				_vScrollBar.setTo(_scrollRect.height, vmax, _scrollRect.y);
				_vScrollBar.height = (hmax > 0 ? _height - _hScrollBar.height : _height);
				if (!_vScrollBar.visible) {
					_vScrollBar.visible = true;
					_vScrollBar.onValueChange = onVValueChange;
				}
			} else if (_vScrollBar.visible) {
				_scrollRect.width = _width - _padding.left - _padding.right;
				_vScrollBar.value = 0;
				_vScrollBar.visible = false;
				_vScrollBar.onValueChange = null;
			}
			if (hmax > 0) {
				_hScrollBar.setTo(_scrollRect.width, hmax, _scrollRect.x);
				_hScrollBar.width = (vmax > 0 ? _width - _vScrollBar.width : _width);
				if (!_hScrollBar.visible) {
					_hScrollBar.visible = true;
					_hScrollBar.onValueChange = onHValueChange;
				}
			} else if (_hScrollBar.visible) {
				_hScrollBar.value = 0;
				_hScrollBar.visible = false;
				_hScrollBar.onValueChange = null;
			}
			_scrollRect.width = _width - (vmax > 0 ? _vScrollBar.width : 0) - _padding.left - _padding.right;
			_scrollRect.height = _height - (hmax > 0 ? _hScrollBar.height : 0) - _padding.top - _padding.bottom;
			_content.scrollRect = _scrollRect;
		}

		protected function onVValueChange() : void {
			_scrollRect.y = _vScrollBar.value;
			_content.scrollRect = _scrollRect;
		}

		protected function onHValueChange() : void {
			_scrollRect.x = _hScrollBar.value;
			_content.scrollRect = _scrollRect;
		}

		public function GScroller() {
		}

		public function add(value : GBase) : void {
			_content.addChild(value);
			callLater(changeBounds);
			callLater(changeScroll);
		}
	}
}
