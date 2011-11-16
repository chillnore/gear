package gear.particle.init {
	import gear.particle.core.Emitter;
	import gear.particle.core.Particle;

	/**
	 * @author Administrator
	 */
	public class AlphaInit extends InitBase {
		protected var _min : Number;
		protected var _max : Number;

		public function AlphaInit(minAlpha : Number = 1, maxAlpha : Number = NaN) {
			priority = -10;
			_min = minAlpha;
			if ( isNaN(maxAlpha) ) {
				_max = _min;
			} else {
				_max = maxAlpha;
			}
		}

		override public function init(emitter : Emitter, particle : Particle) : void {
			emitter;
			var alpha : Number;
			if ( _max == _min ) {
				alpha = _min;
			} else {
				alpha = _min + Math.random() * ( _max - _min );
			}
			particle.color = ( particle.color & 0xFFFFFF ) | ( Math.round(alpha * 255) << 24 );
		}
	}
}
