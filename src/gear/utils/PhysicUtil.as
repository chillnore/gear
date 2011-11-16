package gear.utils {
	/**
	 * 物理工具类
	 * 
	 * @author bright
	 * @version 20111017
	 */
	public class PhysicUtil {
		public static function getFlyH(target : Array, high : int, total : int) : void {
			var half : int = total * 0.5;
			var gravity : Number = high * 2 / (half * (half - 1));
			var speed : Number = -half * gravity;
			target.splice(0);
			var start : Number = 0;
			var i : int;
			for (i = 0;i < half;i++) {
				target.push(Math.round(start));
				speed += gravity;
				start += speed;
			}
			i = target.length;
			while (--i > -1) {
				target.push(target[i]);
			}
		}

		public static function getAgainFlyH(target : Array, start : Number, upH : int, upF : int, dropH : int, dropF : int) : void {
			var gravity : Number = upH * 2 / (upF * (upF - 1));
			var speed : Number = -upF * gravity;
			target.splice(0);
			var i : int;
			for (i = 0;i < upF;i++) {
				target.push(Math.round(start));
				speed += gravity;
				start += speed;
			}
			gravity = dropH * 2 / (dropF * (dropF - 1));
			speed = -dropF * gravity;
			start = 0;
			var drop : Array = new Array();
			for (i = 0;i < dropF;i++) {
				drop.push(Math.round(start));
				speed += gravity;
				start += speed;
			}
			i = drop.length;
			while (--i > -1) {
				target.push(drop[i]);
			}
		}

		public static function getBacks(target : Array, distance : int, total : int) : void {
			var acceleration : Number = distance * 2 / (total * (total - 1));
			var speed : Number = total * acceleration;
			target.splice(0);
			var i : int;
			for (i = 0;i < total;i++) {
				speed -= acceleration;
				target.push(Math.round(speed));
			}
		}

		public static function getUniformBacks(target : Array, distance : int, total : int) : void {
			target.splice(0);
			var speed : Number;
			while (total > 0) {
				speed = distance / total;
				distance -= speed;
				total--;
				target.push(Math.round(speed));
			}
		}
	}
}
