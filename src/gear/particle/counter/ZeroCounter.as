package gear.particle.counter {
	import gear.particle.core.Emitter;

	/**
	 * @author bright
	 * @version 20111027
	 */
	public class ZeroCounter implements ICounter {
		public function ZeroCounter() {
		}

		public function startEmitter(value : Emitter) : int {
			return 0;
		}

		public function updateEmitter(emitter : Emitter, elapsed : int) : uint {
			return 0;
		}

		public function stop() : void {
		}

		public function resume() : void {
		}

		public function get complete() : Boolean {
			return true;
		}

		public function get running() : Boolean {
			return false;
		}
	}
}
