package gear.game.map {
	import gear.render.GFrameRender;
	import gear.render.GRenderCall;
	import gear.utils.GMathUtil;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * 滚动控制器(参考卡马克卷轴算法)
	 * 
	 * @author bright
	 * @version 20120531
	 */
	public class GScrollControl {
		protected var _canvas_bp : Bitmap;
		protected var _objectLayer : Sprite;
		protected var _viewRect : Rectangle;
		protected var _gapW : int;
		protected var _gapH : int;
		protected var _gd_bd : BitmapData;
		protected var _limitW : int;
		protected var _limitH : int;
		protected var _cutRect : Rectangle;
		protected var _gdRect : Rectangle;
		protected var _topRight : Point;
		protected var _offsetX : int;
		protected var _offsetY : int;
		protected var _render_rc : GRenderCall;
		protected var _shock_rc : GRenderCall;
		protected var _shockTotal : int;

		private function checkShock() : void {
			var count : int = _shock_rc.count;
			if (count >= _shockTotal) {
				GFrameRender.instance.remove(_shock_rc);
				return;
			}
			var dx : int = (count % 2 == 0 ? -2 : 2);
			var dy : int = (count % 2 == 0 ? -2 : 2);
			offsetTo(dx, dy);
		}

		private function render() : void {
			var nx : int = _viewRect.x + _offsetX;
			var ny : int = _viewRect.y + _offsetY;
			var bd : BitmapData = _canvas_bp.bitmapData;
			bd.lock();
			_gdRect.x = nx;
			_gdRect.y = ny;
			bd.copyPixels(_gd_bd, _gdRect, GMathUtil.ZERO_POINT, null, null, true);
			bd.unlock();
			_cutRect.x = nx;
			_cutRect.y = ny;
			_objectLayer.scrollRect = _cutRect;
			_offsetX = _offsetY = 0;
		}

		public function renderScroll() : void {
			var nx : int = _viewRect.x + _offsetX;
			var ny : int = _viewRect.y + _offsetY;
			var bd : BitmapData = _canvas_bp.bitmapData;
			bd.lock();
			_gdRect.x = nx;
			_gdRect.y = ny;
			bd.copyPixels(_gd_bd, _gdRect, GMathUtil.ZERO_POINT, null, null, true);
			bd.unlock();
			_cutRect.x = nx;
			_cutRect.y = ny;
			_objectLayer.scrollRect = _cutRect;
			_offsetX = _offsetY = 0;
		}

		public function GScrollControl(canvas_bp : Bitmap, objectLayer : Sprite, viewW : int, viewH : int) {
			_canvas_bp = canvas_bp;
			_objectLayer = objectLayer;
			_canvas_bp.bitmapData = new BitmapData(viewW, viewH, true, 0);
			_canvas_bp.smoothing = true;
			_viewRect = new Rectangle(0, 0, viewW, viewH);
			_cutRect = _viewRect.clone();
			_gdRect = new Rectangle();
			_gapW = viewW * 0.35;
			_gapH = viewH * 0.18;
			_offsetX = 0;
			_offsetY = 0;
			_topRight = new Point();
			_render_rc = new GRenderCall(renderScroll);
			_shock_rc = new GRenderCall(checkShock);
		}

		public function reset() : void {
			/*
			_mapData = value;
			var id : String = String(_mapData.id);
			var lib : String = id + ".swf";
			_gdRect.width = Math.min(_gd_bd.width, _viewRect.width);
			_gdRect.height = _viewRect.height;
			_limitW = _mapData.width - _viewRect.width;
			_limitH = _mapData.height - _viewRect.height;
			 * 
			 */
		}

		public function center(x : int, y : int) : void {
			_viewRect.x = GMathUtil.clamp(x - _viewRect.width * 0.5, 0, _limitW);
			_viewRect.y = GMathUtil.clamp(y - _viewRect.height * 0.5, 0, _limitH);
			_viewRect.y = _limitH;
			render();
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
				render();
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
			if (_viewRect.x - _cutRect.x != x || _viewRect.y - _cutRect.y != y) {
				_offsetX = x;
				_offsetY = y;
				render();
			}
		}

		public function startShock(value : int) : void {
			_shockTotal = value;
			_shock_rc.reset();
			GFrameRender.instance.add(_shock_rc);
		}
	}
}