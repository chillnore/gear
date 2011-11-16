package gear.particle.zone {
	import gear.particle.core.Particle;

	import flash.geom.Point;

	/**
	 * @author Administrator
	 */
	public class PointZone implements IZone {
		protected var _point : Point;

		public function PointZone(point : Point = null) {
			_point = point;
			if (_point == null) {
				_point = new Point();
			}
		}

		public function contains(x : Number, y : Number) : Boolean {
			return _point.x == x && _point.y == y;
		}

		public function getLocation() : Point {
			return _point.clone();
		}

		public function getArea() : Number {
			return 1;
		}

		public function collideParticle(particle : Particle, bounce : Number = 1) : Boolean {
			trace("###");
			var relativeOldX : Number = particle.oldX - _point.x;
			var relativeOldY : Number = particle.oldY - _point.y;
			var dot : Number = relativeOldX * particle.speedX + relativeOldY * particle.speedY;
			if ( dot >= 0 ) {
				return false;
			}
			var relativeX : Number = particle.x - _point.x;
			var relativeY : Number = particle.y - _point.y;
			var radius : Number = particle.collisionRadius;
			dot = relativeX * particle.speedX + relativeY * particle.speedY;
			if ( dot <= 0 ) {
				if ( relativeX > radius || relativeX < -radius ) {
					return false;
				}
				if ( relativeY > radius || relativeY < -radius ) {
					return false;
				}
				if ( relativeX * relativeX + relativeY * relativeY > radius * radius ) {
					return false;
				}
			}

			var frameVelX : Number = relativeX - relativeOldX;
			var frameVelY : Number = relativeY - relativeOldY;
			var a : Number = frameVelX * frameVelX + frameVelY * frameVelY;
			var b : Number = 2 * ( relativeOldX * frameVelX + relativeOldY * frameVelY );
			var c : Number = relativeOldX * relativeOldX + relativeOldY * relativeOldY - radius * radius;
			var sq : Number = b * b - 4 * a * c;
			if ( sq < 0 ) {
				return false;
			}
			var srt : Number = Math.sqrt(sq);
			var t1 : Number = ( -b + srt ) / ( 2 * a );
			var t2 : Number = ( -b - srt ) / ( 2 * a );
			var t : Array = new Array();

			if ( t1 > 0 && t1 <= 1 ) {
				t.push(t1);
			}
			if ( t2 > 0 && t2 <= 1 ) {
				t.push(t2);
			}
			var time : Number;
			if ( t.length == 0 ) {
				return false;
			}
			if ( t.length == 1 ) {
				time = t[0];
			} else {
				time = Math.min(t1, t2);
			}
			var cx : Number = relativeOldX + time * frameVelX + _point.x;
			var cy : Number = relativeOldY + time * frameVelY + _point.y;
			var nx : Number = cx - _point.x;
			var ny : Number = cy - _point.y;
			var d : Number = Math.sqrt(nx * nx + ny * ny);
			nx /= d;
			ny /= d;
			var n : Number = frameVelX * nx + frameVelY * ny;
			frameVelX -= 2 * nx * n;
			frameVelY -= 2 * ny * n;
			particle.x = cx + ( 1 - time ) * frameVelX;
			particle.y = cy + ( 1 - time ) * frameVelY;
			var normalVel : Number = particle.speedX * nx + particle.speedY * ny;
			particle.speedX -= (1 + bounce) * nx * normalVel;
			particle.speedY -= (1 + bounce) * ny * normalVel;
			return true;
		}
	}
}
