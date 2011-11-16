package gear.particle.init {
	import gear.particle.core.Emitter;
	import gear.particle.core.Particle;

	/**
	 * @author bright
	 * @version 20111027
	 */
	public class ScaleInit extends InitBase {
		protected var _min : Number;
		protected var _max : Number;

		public function ScaleInit(minScale : Number = 1, maxScale : Number = NaN) {
			_min = minScale;
			_max = maxScale;
			if ( isNaN(maxScale) ) {
				_max = _min;
			}
		}

		override public function init(emitter : Emitter, particle : Particle) : void {
			emitter;
			if ( _max == _min ) {
				particle.scale = _min;
			} else {
				particle.scale = _min + Math.random() * ( _max - _min );
			}
		}
	}
}
