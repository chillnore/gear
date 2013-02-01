package gear.effect {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	/**
	 * @author bright
	 */
	public class GBreeze extends Sprite {
		protected var _width : int;
		protected var _height : int;

		protected function update() : void {
			var bd : BitmapData;
			bd.perlinNoise(100, 0, 1, Math.random() * 10, false, true, 1, true);
			
		}

		public function GBreeze(target : DisplayObject) {
			var bounds : Rectangle = target.getBounds(target);
			var offsetX : int = 20;
			var offsetY : int = 20;
			_width = bounds.width + offsetX;
			_height = bounds.height + offsetY;
			bounds.x -= offsetX >> 1;
			bounds.y -= offsetY >> 1;
			var bd : BitmapData = new BitmapData(_width, _height, true, 0x00000000);
			bd.draw(target, new Matrix(1, 0, 0, 1, -bounds.x, -bounds.y), null, null, null, true);
		}
	}
}
