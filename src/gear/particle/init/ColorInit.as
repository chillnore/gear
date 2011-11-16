package gear.particle.init {
	import gear.particle.core.Emitter;
	import gear.particle.core.Particle;
	import gear.utils.GColorUtil;

	/**
	 * @author Administrator
	 */
	public class ColorInit extends InitBase {
		protected var _min : uint;
		protected var _max : uint;

		public function ColorInit(color1 : uint = 0xFFFFFF, color2 : uint = 0xFFFFFF) {
			_min = color1;
			_max = color2;
		}

		override public function init(emitter : Emitter, particle : Particle) : void {
			emitter;
			if ( _max == _min ) {
				particle.color = _min;
			} else {
				particle.color = GColorUtil.interpolateColors(_min, _max, Math.random());
			}
		}
	}
}
