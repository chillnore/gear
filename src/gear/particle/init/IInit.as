package gear.particle.init {
	import gear.particle.core.Emitter;
	import gear.particle.core.IBehaviour;
	import gear.particle.core.Particle;

	/**
	 * @author bright
	 * @version 20111027
	 */
	public interface IInit extends IBehaviour {
		function init(emitter : Emitter, particle : Particle) : void;
	}
}
