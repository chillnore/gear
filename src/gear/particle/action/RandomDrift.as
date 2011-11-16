package gear.particle.action {
	import gear.particle.core.Emitter;
	import gear.particle.core.Particle;

	/**
	 * RandomDrift 随机飘动
	 * 
	 * @author bright
	 * @version 20111027
	 */
	public class RandomDrift extends ActionBase {
		private var _sizeX : Number;
		private var _sizeY : Number;

		public function RandomDrift(driftX : Number = 0, driftY : Number = 0) {
			_sizeX = driftX * 0.5;
			_sizeY = driftY * 2;
		}

		override public function update(emitter : Emitter, particle : Particle, elapsed : int) : void {
			emitter;
			particle.speedX += ( Math.random() - 0.5 ) * _sizeX * elapsed / 1000;
			particle.speedY += ( Math.random() - 0.5 ) * _sizeY * elapsed / 1000;
		}
	}
}
