package gear.render {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import gear.utils.BDUtil;
	import gear.utils.MathUtil;

	/**
	 * 滚动控制器(参考卡马克卷轴算法)
	 * 
	 * @author bright
	 * @version 20111017
	 */
	public class Camera2C {
		protected var _canvas_bp : Bitmap;
		protected var _viewRect : Rectangle;
		protected var _gapW : int;
		protected var _gapH : int;
		protected var _bg_bd : BitmapData;
		protected var _gd_bd : BitmapData;
		protected var _foreW : int;
		protected var _foreH : int;
		protected var _limitW : int;
		protected var _limitH : int;
		protected var _parallax : Number;
		protected var _cutRect : Rectangle;
		protected var _offset : Point;
		protected var _change : Boolean;

		public function render() : void {
			if (!_change) {
				return;
			}
			_change = false;
			var nx : int = _viewRect.x + _offset.x;
			var ny : int = _viewRect.y + _offset.y;
			var bd : BitmapData = _canvas_bp.bitmapData;
			bd.lock();
			_cutRect.x = int(nx * _parallax);
			_cutRect.y = int(ny * _parallax);
			bd.copyPixels(_bg_bd, _cutRect, MathUtil.ZERO_POINT);
			_cutRect.x = nx;
			_cutRect.y = ny;
			bd.copyPixels(_gd_bd, _cutRect, MathUtil.ZERO_POINT, null, null, true);
			bd.unlock();
		}

		public function Camera2C(canvas_bp : Bitmap, viewW : int, viewH : int, gapW : int = 180, gapH : int = 150) {
			_canvas_bp = canvas_bp;
			_canvas_bp.bitmapData = new BitmapData(viewW, viewH, true, 0);
			_canvas_bp.smoothing = true;
			_viewRect = new Rectangle(0, 0, viewW, viewH);
			_cutRect = _viewRect.clone();
			_gapW = gapW;
			_gapH = gapH;
			_parallax = 0.5;
			_offset = new Point(0, 0);
		}

		public function reset(bg_bd : BitmapData, gd_bd : BitmapData) : void {
			_gd_bd = gd_bd;
			_foreW = _gd_bd.width;
			_foreH = _gd_bd.height;
			_limitW = _foreW - _viewRect.width;
			_limitH = _foreH - _viewRect.height;
			_bg_bd = BDUtil.getResizeBD(bg_bd, _foreW - int(_limitW * _parallax), _foreH - int(_limitH * _parallax));
			_viewRect.x = 0;
			_viewRect.y = _limitH;
			_change = true;
		}

		public function get foreW() : int {
			return _foreW;
		}

		public function get foreH() : int {
			return _foreH;
		}

		/**
		 * 检测是否需要滚动(只有可视区域变化时刷新)
		 * 
		 * @param x 自己的x坐标
		 * @param y 自己的y坐标
		 * @param dx x坐标变化
		 * @param dy y坐标变化
		 */
		public function checkScroll(x : int, y : int, dx : int, dy : int) : void {
			var newX : int;
			var newY : int;
			var scrollX : Boolean = false;
			var scrollY : Boolean = false;
			if (dx > 0) {
				if (_viewRect.right - x < _gapW || x > _viewRect.right) {
					newX = Math.min(x + _gapW - _viewRect.width, _limitW);
					if (_viewRect.x != newX) {
						_viewRect.x = newX;
						scrollX = true;
					}
				}
			} else if (dx < 0) {
				if (x - _viewRect.x < _gapW || x < _viewRect.x) {
					newX = Math.max(0, x - _gapW);
					if (_viewRect.x != newX) {
						_viewRect.x = newX;
						scrollX = true;
					}
				}
			}
			if (dy > 0) {
				if (_viewRect.bottom - y < _gapH || y > _viewRect.bottom ) {
					newY = Math.min(y + _gapH - _viewRect.height, _limitH);
					if (_viewRect.y != newY) {
						_viewRect.y = newY;
						scrollY = true;
					}
				}
			} else if (dy < 0) {
				if (y - _viewRect.y < _gapH || y < _viewRect.y) {
					newY = Math.max(0, y - _gapH);
					if (_viewRect.y != newY) {
						_viewRect.y = newY;
						scrollY = true;
					}
				}
			}
			if (scrollX || scrollY) {
				_change = true;
			}
		}

		public function offsetTo(x : int, y : int) : void {
			var nx : int = _viewRect.x + x;
			if (nx < 0 || nx > _limitW) {
				x = 0;
			}
			var ny : int = _viewRect.y + y;
			if (ny < 0 || ny > _limitH) {
				y = 0;
			}
			if (_offset.x != x || _offset.y != y) {
				_offset.x = x;
				_offset.y = y;
				_change = true;
			}
		}

		public function get offsetX() : int {
			return _cutRect.x;
		}

		public function get offsetY() : int {
			return _cutRect.y;
		}
	}
}