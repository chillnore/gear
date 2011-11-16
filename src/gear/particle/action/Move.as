package gear.particle.action {
	import gear.particle.core.Emitter;
	import gear.particle.core.Particle;

	/**
	 * @author Administrator
	 */
	public class Move extends ActionBase {
		public function Move() {
			_priority = -10;
		}

		override public function update(emitter : Emitter, particle : Particle, elapsed : int) : void {
			emitter;
			particle.x += particle.speedX * elapsed;
			particle.y += particle.speedY * elapsed;
		}
	}
}
