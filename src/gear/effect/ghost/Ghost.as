package gear.effect.ghost {
	import gear.pool.ObjPool;
	import gear.render.BDUnit;
	import gear.render.FrameRender;
	import gear.render.IFrame;

	import flash.display.Bitmap;
	import flash.display.Sprite;

	/**
	 * @author flashpf
	 */
	public class Ghost extends Sprite implements IFrame {
		public static const pool : ObjPool = new ObjPool(Ghost);
		protected var _bitmap : Bitmap;
		protected var _unit : BDUnit;
		protected var _count : int;

		public function Ghost() : void {
			_bitmap = new Bitmap();
			addChild(_bitmap);
		}

		public function reset(newX : int, newY : int, z : int, unit : BDUnit) : void {
			x = newX;
			y = newY - 1;
			_unit = unit;
			_bitmap.x = unit.offsetX;
			_bitmap.y = z + unit.offsetY;
			_count = 0;
			FrameRender.instance.add(this);
		}

		public function refresh() : void {
			_count++;
			if (_count > 15) {
				if (parent != null) {
					parent.removeChild(this);
				}
				FrameRender.instance.remove(this);
				pool.returnObj(this);
				return;
			}
			if (_count == 1) {
				_bitmap.bitmapData = _unit.bd;
				_bitmap.alpha = 0.6;
			} else {
				_bitmap.alpha -= 0.04;
			}
		}
	}
}
