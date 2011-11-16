package gear.particle.init {
	import gear.particle.core.Emitter;
	import gear.particle.core.Particle;
	import gear.particle.zone.IZone;

	import flash.geom.Point;

	/**
	 * @author Administrator
	 */
	public class Position extends InitBase {
		protected var _zone : IZone;

		public function Position(zone : IZone = null) {
			_zone = zone;
		}

		override public function init(emitter : Emitter, particle : Particle) : void {
			emitter;
			var loc : Point = _zone.getLocation();
			if ( particle.rotation == 0 ) {
				particle.x += loc.x;
				particle.y += loc.y;
			} else {
				var sin : Number = Math.sin(particle.rotation);
				var cos : Number = Math.cos(particle.rotation);
				particle.x += cos * loc.x - sin * loc.y;
				particle.y += cos * loc.y + sin * loc.x;
			}
		}
	}
}
