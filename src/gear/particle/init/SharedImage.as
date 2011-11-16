package gear.particle.init {
	import gear.particle.core.Emitter;
	import gear.particle.core.Particle;

	import flash.display.DisplayObject;

	/**
	 * @author Administrator
	 */
	public class SharedImage extends InitBase {
		protected var _image : DisplayObject;

		public function SharedImage(image : DisplayObject = null) {
			_image = image;
		}

		override public function init(emitter : Emitter, particle : Particle) : void {
			emitter;
			particle.image = _image;
		}
	}
}
