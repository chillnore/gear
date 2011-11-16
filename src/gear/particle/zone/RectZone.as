package gear.particle.zone {
	import gear.particle.core.Particle;

	import flash.geom.Point;

	/**
	 * @author Administrator
	 */
	public class RectZone implements IZone {
		protected var _left : Number;
		protected var _top : Number;
		protected var _right : Number;
		protected var _bottom : Number;
		protected var _width : Number;
		protected var _height : Number;

		public function RectZone(left : Number = 0, top : Number = 0, right : Number = 0, bottom : Number = 0) {
			_left = left;
			_top = top;
			_right = right;
			_bottom = bottom;
		}

		public function contains(x : Number, y : Number) : Boolean {
			return x >= _left && x <= _right && y >= _top && y <= _bottom;
		}

		public function getLocation() : Point {
			return new Point(_left + Math.random() * _width, _top + Math.random() * _height);
		}

		public function getArea() : Number {
			return _width * _height;
		}

		public function collideParticle(particle : Particle, bounce : Number = 1) : Boolean {
			var position : Number;
			var oldPosition : Number;
			var intersect : Number;
			var collision : Boolean = false;
			if ( particle.speedX > 0 ) {
				position = particle.x + particle.collisionRadius;
				oldPosition = particle.oldX + particle.collisionRadius;
				if ( oldPosition < _left && position >= _left ) {
					intersect = particle.oldY + ( particle.y - particle.oldY ) * ( _left - oldPosition ) / ( position - oldPosition );
					if ( intersect >= _top - particle.collisionRadius && intersect <= _bottom + particle.collisionRadius ) {
						particle.speedX = -particle.speedX * bounce;
						particle.x += 2 * ( _left - position );
						collision = true;
					}
				} else if ( oldPosition <= _right && position > _right ) {
					intersect = particle.oldY + ( particle.y - particle.oldY ) * ( _right - oldPosition ) / ( position - oldPosition );
					if ( intersect >= _top - particle.collisionRadius && intersect <= _bottom + particle.collisionRadius ) {
						particle.speedX = -particle.speedX * bounce;
						particle.x += 2 * ( _right - position );
						collision = true;
					}
				}
			} else if ( particle.speedX < 0 ) {
				position = particle.x - particle.collisionRadius;
				oldPosition = particle.oldX - particle.collisionRadius;
				if ( oldPosition > _right && position <= _right ) {
					intersect = particle.oldY + ( particle.y - particle.oldY ) * ( _right - oldPosition ) / ( position - oldPosition );
					if ( intersect >= _top - particle.collisionRadius && intersect <= _bottom + particle.collisionRadius ) {
						particle.speedX = -particle.speedX * bounce;
						particle.x += 2 * ( _right - position );
						collision = true;
					}
				} else if ( oldPosition >= _left && position < _left ) {
					intersect = particle.oldY + ( particle.y - particle.oldY ) * ( _left - oldPosition ) / ( position - oldPosition );
					if ( intersect >= _top - particle.collisionRadius && intersect <= _bottom + particle.collisionRadius ) {
						particle.speedX = -particle.speedX * bounce;
						particle.x += 2 * ( _left - position );
						collision = true;
					}
				}
			}

			if ( particle.speedY > 0 ) {
				position = particle.y + particle.collisionRadius;
				oldPosition = particle.oldY + particle.collisionRadius;
				if ( oldPosition < _top && position >= _top ) {
					intersect = particle.oldX + ( particle.x - particle.oldX ) * ( _top - oldPosition ) / ( position - oldPosition );
					if ( intersect >= _left - particle.collisionRadius && intersect <= _right + particle.collisionRadius ) {
						particle.speedY = -particle.speedY * bounce;
						particle.y += 2 * ( _top - position );
						collision = true;
					}
				} else if ( oldPosition <= _bottom && position > _bottom ) {
					intersect = particle.oldX + ( particle.x - particle.oldX ) * ( _bottom - oldPosition ) / ( position - oldPosition );
					if ( intersect >= _left - particle.collisionRadius && intersect <= _right + particle.collisionRadius ) {
						particle.speedY = -particle.speedY * bounce;
						particle.y += 2 * ( _bottom - position );
						collision = true;
					}
				}
			} else if ( particle.speedY < 0 ) {
				position = particle.y - particle.collisionRadius;
				oldPosition = particle.oldY - particle.collisionRadius;
				if ( oldPosition > _bottom && position <= _bottom ) {
					intersect = particle.oldX + ( particle.x - particle.oldX ) * ( _bottom - oldPosition ) / ( position - oldPosition );
					if ( intersect >= _left - particle.collisionRadius && intersect <= _right + particle.collisionRadius ) {
						particle.speedY = -particle.speedY * bounce;
						particle.y += 2 * ( _bottom - position );
						collision = true;
					}
				} else if ( oldPosition >= _top && position < _top ) {
					intersect = particle.oldX + ( particle.x - particle.oldX ) * ( _top - oldPosition ) / ( position - oldPosition );
					if ( intersect >= _left - particle.collisionRadius && intersect <= _right + particle.collisionRadius ) {
						particle.speedY = -particle.speedY * bounce;
						particle.y += 2 * ( _top - position );
						collision = true;
					}
				}
			}
			return collision;
		}
	}
}
