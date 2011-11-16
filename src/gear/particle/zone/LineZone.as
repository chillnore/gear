package gear.particle.zone {
	import flash.geom.Point;

	import gear.particle.core.Particle;

	/**
	 * @author Administrator
	 */
	public class LineZone implements IZone {
		protected var _start : Point;
		protected var _end : Point;
		protected var _length : Point;
		protected var _normal : Point;
		protected var _parallel : Point;

		protected function setLengthAndNormal() : void {
			_length = _end.subtract(_start);
			_parallel = _length.clone();
			_parallel.normalize(1);
			_normal = new Point(_parallel.y, - _parallel.x);
		}

		public function LineZone(start : Point = null, end : Point = null) {
			_start = start;
			_end = end;
			if (_start == null) {
				_start = new Point(0, 0);
			}
			if (_end == null) {
				_end = new Point(0, 0);
			}
			setLengthAndNormal();
		}

		public function contains(x : Number, y : Number) : Boolean {
			if ( ( x - _start.x ) * _length.y - ( y - _start.y ) * _length.x != 0 ) {
				return false;
			}
			return ( x - _start.x ) * ( x - _end.x ) + ( y - _start.y ) * ( y - _end.y ) <= 0;
		}

		public function getLocation() : Point {
			var ret : Point = _start.clone();
			var scale : Number = Math.random();
			ret.x += _length.x * scale;
			ret.y += _length.y * scale;
			return ret;
		}

		public function getArea() : Number {
			return _length.length;
		}

		public function collideParticle(particle : Particle, bounce : Number = 1) : Boolean {
			var oldDistance : Number = ( particle.oldX - _start.x ) * _normal.x + ( particle.oldY - _start.y ) * _normal.y;
			var speedDistance : Number = particle.speedX * _normal.x + particle.speedY * _normal.y;
			if ( oldDistance * speedDistance >= 0 ) {
				return false;
			}
			var distance : Number = ( particle.x - _start.x ) * _normal.x + ( particle.y - _start.y ) * _normal.y;
			if ( distance * oldDistance > 0 && ( distance > particle.collisionRadius || distance < -particle.collisionRadius ) ) {
				return false;
			}
			var offsetX : Number;
			var offsetY : Number;
			if ( oldDistance < 0 ) {
				offsetX = _normal.x * particle.collisionRadius;
				offsetY = _normal.y * particle.collisionRadius;
			} else {
				offsetX = - _normal.x * particle.collisionRadius;
				offsetY = - _normal.y * particle.collisionRadius;
			}
			var thenX : Number = particle.oldX + offsetX;
			var thenY : Number = particle.oldY + offsetY;
			var nowX : Number = particle.x + offsetX;
			var nowY : Number = particle.y + offsetY;
			var startX : Number = _start.x - _parallel.x * particle.collisionRadius;
			var startY : Number = _start.y - _parallel.y * particle.collisionRadius;
			var endX : Number = _end.x + _parallel.x * particle.collisionRadius;
			var endY : Number = _end.y + _parallel.y * particle.collisionRadius;

			var den : Number = 1 / ( ( nowY - thenY ) * ( endX - startX ) - ( nowX - thenX ) * ( endY - startY ) );

			var u : Number = den * ( ( nowX - thenX ) * ( startY - thenY ) - ( nowY - thenY ) * ( startX - thenX ) );
			if ( u < 0 || u > 1 ) {
				return false;
			}

			var v : Number = - den * ( ( endX - startX ) * ( thenY - startY ) - ( endY - startY ) * ( thenX - startX ) );
			if ( v < 0 || v > 1 ) {
				return false;
			}

			particle.x = particle.oldX + v * ( particle.x - particle.oldX );
			particle.y = particle.oldY + v * ( particle.y - particle.oldY );

			var normalSpeed : Number = _normal.x * particle.speedX + _normal.y * particle.speedY;
			var factor : Number = ( 1 + bounce ) * normalSpeed;
			particle.speedX -= factor * _normal.x;
			particle.speedY -= factor * _normal.y;
			return true;
		}
	}
}
