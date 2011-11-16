package gear.particle.action {
	import gear.particle.core.Emitter;
	import gear.particle.core.IBehaviour;
	import gear.particle.core.Particle;

	/**
	 * @author bright
	 * @version 20111027
	 */
	public interface IAction extends IBehaviour {
		function update(emitter : Emitter, particle : Particle, elapsed : int) : void;
	}
}
