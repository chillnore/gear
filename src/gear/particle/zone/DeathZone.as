package gear.particle.zone {
	import gear.particle.action.ActionBase;
	import gear.particle.core.Emitter;
	import gear.particle.core.Particle;

	public final class DeathZone extends ActionBase {
		private var _zone : IZone;
		private var _invertZone : Boolean;
		private var _inside : Boolean;

		public function DeathZone(zone : IZone = null, invertZone : Boolean = false) {
			_priority = -20;
			_zone = zone;
			_invertZone = invertZone;
		}

		public function set zone(value : IZone) : void {
			_zone = value;
		}

		public function get zone() : IZone {
			return _zone;
		}

		public function get zoneIsSafe() : Boolean {
			return _invertZone;
		}

		public function set zoneIsSafe(value : Boolean) : void {
			_invertZone = value;
		}

		override public function update(emitter : Emitter, particle : Particle, elapsed : int) : void {
			emitter;
			elapsed;
			_inside = _zone.contains(particle.x, particle.y);
			if ( _invertZone ) {
				if ( !_inside ) {
					particle.isDead = true;
				}
			} else {
				if (_inside ) {
					particle.isDead = true;
				}
			}
		}
	}
}
