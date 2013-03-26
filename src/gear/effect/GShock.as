package gear.effect {
	import gear.utils.GMathUtil;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author bright
	 */
	public class GShock  extends GEffect {
		protected var _offsetX : int;
		protected var _offsetY : int;
		protected var _glow : GlowFilter;
		protected var _glow2 : GlowFilter;
		protected var _glow3 : GlowFilter;
		protected var _show : Sprite;
		protected var _seed : Number;
		protected var _offsets : Array;
		protected var _bd : BitmapData;
		protected var _show_bd : BitmapData;
		protected var _spark_bd : BitmapData;

		override protected function onChangeTarget() : void {
			var bounds : Rectangle = _target.getBounds(_target);
			var offsetX : int = 20;
			var offsetY : int = 20;
			var w : int = bounds.width + offsetX;
			var h : int = bounds.height + offsetY;
			bounds.x = bounds.x - (offsetX >> 1);
			bounds.y = bounds.y - (offsetY >> 1);
			_show = new Sprite();
			_show.x = _target.x;
			_show.y = _target.y;
			_target.parent.addChild(_show);
			var holder : Sprite = new Sprite();
			holder.x = bounds.x;
			holder.y = bounds.y;
			_show.addChild(holder);
			_bd = new BitmapData(w, h, true, 0);
			_spark_bd = new BitmapData(w, h, true, 0);
			_bd.draw(_target, new Matrix(1, 0, 0, 1, -bounds.x, -bounds.y));
			var spark_bp : Bitmap = new Bitmap();
			spark_bp.bitmapData = _spark_bd;
			holder.addChild(spark_bp);
			_offsets = new Array();
			for (var i : int = 0;i < 4;i++) {
				_offsets[i] = new Point();
			}
			_seed = Math.round(Math.random() * 10);
			_show_bd = new BitmapData(w, h);
			_target.filters = [_glow2];
			holder.blendMode = "screen";
			holder.filters = [_glow2, _glow3];
		}

		override protected function next() : void {
			var offset : Point;
			for each (offset in _offsets) {
				offset.x -= _offsetX;
				offset.y += _offsetY;
			}
			_show_bd.perlinNoise(10, 20, 2, _seed, true, true, 1, true, _offsets);
			var filter : DisplacementMapFilter = new DisplacementMapFilter(_show_bd, GMathUtil.ZERO_POINT, 1, 1, 16, 16, "color");
			_spark_bd.applyFilter(_bd, _bd.rect, GMathUtil.ZERO_POINT, _glow);
			_spark_bd.applyFilter(_spark_bd, _bd.rect, GMathUtil.ZERO_POINT, filter);
		}

		public function GShock(delay : int = 50) {
			super(-1, delay);
			_offsetX = 2;
			_offsetY = 2;
			_glow = new GlowFilter(0xFFFF, 1, 1, 1, 100, 1, false, true);
			_glow2 = new GlowFilter(0xFFFF, 0.6, 6, 6, 2, 1, false, false);
			_glow3 = new GlowFilter(0x6666FF, 0.8, 8, 8, 3, 1, false, false);
		}
	}
}
