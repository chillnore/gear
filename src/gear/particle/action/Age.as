package gear.particle.action {
	import gear.motion.easing.Linear;
	import gear.particle.core.Emitter;
	import gear.particle.core.Particle;

	/**
	 * @author Administrator
	 */
	public class Age extends ActionBase {
		protected var _easing : Function;

		public function Age(easing : Function = null) {
			if ( easing == null ) {
				_easing = Linear.easeNone;
			} else {
				_easing = easing;
			}
		}

		override public function update(emitter : Emitter, particle : Particle, elapsed : int) : void {
			emitter;
			particle.age += elapsed;
			if ( particle.age >= particle.lifetime ) {
				particle.energy = 0;
				particle.isDead = true;
			} else {
				particle.energy = _easing(particle.age, 1, -1, particle.lifetime);
			}
		}
	}
}
