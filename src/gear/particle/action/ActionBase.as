package gear.particle.action {
	import gear.particle.core.Emitter;
	import gear.particle.core.Particle;

	/**
	 * @author bright
	 * @version 20111027
	 */
	public class ActionBase implements IAction {
		protected var _priority : int;

		public function update(emitter : Emitter, particle : Particle, elapsed : int) : void {
		}

		public function set priority(value : int) : void {
			_priority = value;
		}

		public function get priority() : int {
			return _priority;
		}

		public function addedToEmitter(emitter : Emitter) : void {
		}

		public function removedFromEmitter(emitter : Emitter) : void {
		}
	}
}
