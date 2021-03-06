﻿package gear.effect.ghost {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import gear.gui.bd.GBDFrame;
	import gear.pool.GObjPool;
	import gear.render.GFrameRender;
	import gear.render.IGFrame;


	/**
	 * @author flashpf
	 */
	public class GGhost extends Sprite implements IGFrame {
		public static const pool : GObjPool = new GObjPool(GGhost);
		protected var _bitmap : Bitmap;
		protected var _unit : GBDFrame;
		protected var _count : int;

		public function GGhost() : void {
			_bitmap = new Bitmap();
			addChild(_bitmap);
		}

		public function reset(newX : int, newY : int, z : int, unit : GBDFrame) : void {
			x = newX;
			y = newY - 1;
			_unit = unit;
			_bitmap.x = unit.offsetX;
			_bitmap.y = z + unit.offsetY;
			_count = 0;
			GFrameRender.instance.add(this);
		}

		public function refresh() : void {
			_count++;
			if (_count > 15) {
				if (parent != null) {
					parent.removeChild(this);
				}
				GFrameRender.instance.remove(this);
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
