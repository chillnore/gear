package gear.particle.init {
	import gear.particle.core.Emitter;
	import gear.particle.core.Particle;

	/**
	 * @author Administrator
	 */
	public class InitBase implements IInit {
		protected var _priority : int;

		public function init(emitter : Emitter, particle : Particle) : void {
		}

		public function get priority() : int {
			return _priority;
		}

		public function set priority(value : int) : void {
		}

		public function addedToEmitter(emitter : Emitter) : void {
		}

		public function removedFromEmitter(emitter : Emitter) : void {
		}
	}
}
