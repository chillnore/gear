package gear.particle.counter {
	import gear.particle.core.Emitter;

	/**
	 * @author Administrator
	 */
	public interface ICounter {
		function startEmitter(value : Emitter) : int;

		function updateEmitter(emitter : Emitter, elapsed : int) : uint;

		function stop() : void;

		function resume() : void;

		function get complete() : Boolean;

		function get running() : Boolean;
	}
}
