package gear.particle.shape {
	import gear.utils.GDrawUtil;

	import flash.display.Shape;

	/**
	 * @author Administrator
	 */
	public class Star extends Shape {
		protected var _radius : Number;
		protected var _color : uint;

		protected function draw() : void {
			GDrawUtil.drawStar(graphics, _radius, _color);
		}

		public function Star(radius : Number, color : uint = 0xFFFFFF) {
			_radius = radius;
			_color = color;
			draw();
		}
	}
}
