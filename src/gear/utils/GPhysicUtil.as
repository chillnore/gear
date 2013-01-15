package gear.utils {
	/**
	 * 物理工具类
	 * 
	 * @author bright
	 * @version 20130115
	 */
	public final class GPhysicUtil {
		public static function getTotal(distX : int, speedX : int, startZ : int, high : int, speedZ : int, distY : int = 0, speedY : int = 5) : int {
			var xT : Number = distX / speedX;
			xT = Math.ceil(xT > 0 ? xT : -xT) + 1;
			var yT : Number = distY / speedY;
			yT = Math.ceil(yT > 0 ? yT : -yT) + 1;
			var upT : Number = high / speedZ;
			upT = Math.ceil(upT > 0 ? upT : -upT);
			var dropH : Number = -startZ + high;
			var dropT : Number = dropH / speedZ;
			dropT = Math.ceil(dropT > 0 ? dropT : -dropT);
			var zT : int = upT + dropT;
			return Math.max(xT, yT, zT);
		}

		public static function getAirH(target : Array, high : int, total : int) : void {
			target.length = 0;
			var half : int = total >> 1;
			var gravity : Number = (high << 1) / (half * (half - 1));
			var speed : Number = -half * gravity;
			var start : Number = 0;
			var i : int;
			for (i = 0;i < half;i++) {
				target.push(start + 0.5 | 0);
				speed += gravity;
				start += speed;
			}
			i = target.length;
			while (--i > -1) {
				target.push(target[i]);
			}
		}

		public static function getBacks(target : Array, dist : int, total : int) : void {
			target.length = 0;
			var i : int;
			if (dist == 0) {
				for (i = 0;i < total;i++) {
					target.push(0);
				}
				return;
			}
			var acceleration : Number = (dist << 1) / (total * (total - 1));
			var speed : Number = total * acceleration;
			for (i = 0;i < total;i++) {
				speed -= acceleration;
				target.push(speed + 0.5 | 0);
			}
		}

		public static function getUniformBacks(target : Array, dist : int, total : int) : void {
			target.length = 0;
			var speed : Number;
			while (total > 0) {
				speed = dist / total;
				dist -= speed;
				total--;
				target.push(speed + 0.5 | 0);
			}
		}
	}
}
