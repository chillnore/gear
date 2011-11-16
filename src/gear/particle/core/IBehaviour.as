package gear.particle.core {
	public interface IBehaviour {
		function set priority(value : int) : void;

		function get priority() : int;

		function addedToEmitter(emitter : Emitter) : void;

		function removedFromEmitter(emitter : Emitter) : void;
	}
}