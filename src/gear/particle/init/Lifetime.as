package gear.particle.init {
	import gear.particle.core.Emitter;
	import gear.particle.core.Particle;

	/**
	 * @author Administrator
	 */
	public class Lifetime extends InitBase {
		protected var _min : Number;
		protected var _max : Number;

		public function Lifetime(minLifetime : Number = Number.MAX_VALUE, maxLifetime : Number = NaN) {
			_max = maxLifetime;
			_min = minLifetime;
		}

		override public function init(emitter : Emitter, particle : Particle) : void {
			emitter;
			if ( isNaN(_max) ) {
				particle.lifetime = _min;
			} else {
				particle.lifetime = _min + Math.random() * ( _max - _min );
			}
		}
	}
}
