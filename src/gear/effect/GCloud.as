/*
ActionScript 3 Tutorial by Dan Gries and Barbara Kaskosz

http://www.flashandmath.com/

Last modified: September 13, 2010

For explanations see the tutorial's page:
http://www.flashandmath.com/intermediate/cloudsfast/
 */
package gear.effect {
	import gear.render.GFrameRender;
	import gear.render.GRenderCall;
	import gear.utils.GMathUtil;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class GCloud extends Sprite {
		private var _width : int;
		private var _height : int;
		private var _octaves : int;
		private var _cloudsHeight : Number;
		private var _cloudsWidth : Number;
		private var _periodX : Number;
		private var _periodY : Number;
		private var _scrollX : int;
		private var _scrollY : int;
		private var _max : int;
		private var _clouds_bd : BitmapData;
		private var _clouds_bp : Bitmap;
		private var _cmf : ColorMatrixFilter;
		private var _bgSkin : Shape;
		private var _seed : int;
		private var _offsets : Array;
		private var _sliceDataH : BitmapData;
		private var _sliceDataV : BitmapData;
		private var _sliceDataCorner : BitmapData;
		private var _horizCutRect : Rectangle;
		private var _vertCutRect : Rectangle;
		private var _cornerCutRect : Rectangle;
		private var _horizPastePoint : Point;
		private var _vertPastePoint : Point;
		private var _cornerPastePoint : Point;
		private var _cloudsMask : Shape;
		private var _render_rc : GRenderCall;

		protected function addedToStage(evt : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			GFrameRender.instance.add(_render_rc);
		}

		protected function removedFromStage(evt : Event) : void {
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			GFrameRender.instance.remove(_render_rc);
		}

		protected function makeClouds() : void {
			_seed = int(Math.random() * 10);
			_offsets = new Array();
			for (var i : int = 0; i < _octaves; i++) {
				_offsets.push(new Point());
			}
			_clouds_bd.perlinNoise(_periodX, _periodY, _octaves, _seed, true, false, 7, true, _offsets);
			_clouds_bd.applyFilter(_clouds_bd, _clouds_bd.rect, new Point(), _cmf);
		}

		protected function setRects() : void {
			_scrollX = (_scrollX > _max) ? _max : ((_scrollX < -_max) ? -_max : _scrollX);
			_scrollY = (_scrollY > _max) ? _max : ((_scrollY < -_max) ? -_max : _scrollY);
			if (_scrollX != 0) {
				_sliceDataV = new BitmapData(Math.abs(_scrollX), _cloudsHeight - Math.abs(_scrollY), true);
			}
			if (_scrollY != 0) {
				_sliceDataH = new BitmapData(_cloudsWidth, Math.abs(_scrollY), true);
			}
			if ((_scrollX != 0) && (_scrollY != 0)) {
				_sliceDataCorner = new BitmapData(Math.abs(_scrollX), Math.abs(_scrollY), true);
			}
			_horizCutRect = new Rectangle(0, _cloudsHeight - _scrollY, _cloudsWidth - Math.abs(_scrollX), Math.abs(_scrollY));
			_vertCutRect = new Rectangle(_cloudsWidth - _scrollX, 0, Math.abs(_scrollX), _cloudsHeight - Math.abs(_scrollY));
			_cornerCutRect = new Rectangle(_cloudsWidth - _scrollX, _cloudsHeight - _scrollY, Math.abs(_scrollX), Math.abs(_scrollY));
			_horizPastePoint = new Point(_scrollX, 0);
			_vertPastePoint = new Point(0, _scrollY);
			_cornerPastePoint = new Point(0, 0);
			if (_scrollX < 0) {
				_cornerCutRect.x = _vertCutRect.x = 0;
				_cornerPastePoint.x = _vertPastePoint.x = _cloudsWidth + _scrollX;
				_horizCutRect.x = -_scrollX;
				_horizPastePoint.x = 0;
			}
			if (_scrollY < 0) {
				_cornerCutRect.y = _horizCutRect.y = 0;
				_cornerPastePoint.y = _horizPastePoint.y = _cloudsHeight + _scrollY;
				_vertCutRect.y = -_scrollY;
				_vertPastePoint.y = 0;
			}
		}

		protected function update() : void {
			_clouds_bd.lock();
			if (_scrollX != 0) {
				_sliceDataV.copyPixels(_clouds_bd, _vertCutRect, GMathUtil.ZERO_POINT);
			}
			if (_scrollY != 0) {
				_sliceDataH.copyPixels(_clouds_bd, _horizCutRect, GMathUtil.ZERO_POINT);
			}
			if ((_scrollX != 0) && (_scrollY != 0)) {
				_sliceDataCorner.copyPixels(_clouds_bd, _cornerCutRect, GMathUtil.ZERO_POINT);
			}
			_clouds_bd.scroll(_scrollX, _scrollY);
			if (_scrollX != 0) {
				_clouds_bd.copyPixels(_sliceDataV, _sliceDataV.rect, _vertPastePoint);
			}
			if (_scrollY != 0) {
				_clouds_bd.copyPixels(_sliceDataH, _sliceDataH.rect, _horizPastePoint);
			}
			if ((_scrollX != 0) && (_scrollY != 0)) {
				_clouds_bd.copyPixels(_sliceDataCorner, _sliceDataCorner.rect, _cornerPastePoint);
			}
			_clouds_bd.unlock();
		}

		public function GCloud(w : int = 300, h : int = 200, scrollX : int = -1, scrollY : int = 2, color : uint = 0xFFFFFF) {
			_width = w;
			_height = h;
			_cloudsWidth = Math.floor(1.5 * _width);
			_cloudsHeight = Math.floor(1.5 * _height);
			_periodX = _periodY = 30;
			_scrollX = scrollX;
			_scrollY = scrollY;
			_max = 50;
			_octaves = 4;
			_clouds_bd = new BitmapData(_cloudsWidth, _cloudsHeight, true);
			_clouds_bp = new Bitmap(_clouds_bd);
			var r:int=(color>>16)&0xFF;
			var g:int=(color>>8)&0xFF;
			var b:int=color&0xFF;
			_cmf = new ColorMatrixFilter([0, 0, 0, 0, r, 0, 0, 0, 0, g, 0, 0, 0, 0, b, 1, 0, 0, 0, 0]);
			_cloudsMask = new Shape();
			_cloudsMask.graphics.beginFill(0xFFFFFF);
			_cloudsMask.graphics.drawRect(0, 0, _width, _height);
			_cloudsMask.graphics.endFill();
			_bgSkin = new Shape();
			addChild(_clouds_bp);
			addChild(_cloudsMask);
			_clouds_bp.mask = _cloudsMask;
			makeClouds();
			setRects();
			_render_rc = new GRenderCall(update, 66);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
	}
}
