package gear.particle.shape {
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.geom.Matrix;

	/**
	 * @author bright
	 * @version 20111031
	 */
	public class RadialDot extends Shape {
		protected var _radius : Number;
		protected var _color : uint;
		protected var _matrix : Matrix;

		protected function draw() : void {
			graphics.clear();
			_matrix.identity();
			_matrix.createGradientBox(_radius * 2, _radius * 2, 0, -_radius, -_radius);
			graphics.beginGradientFill(GradientType.RADIAL, [_color, _color], [1, 0], [0, 255], _matrix);
			graphics.drawCircle(0, 0, _radius);
			graphics.endFill();
		}

		public function RadialDot(radius : Number = 1, color : uint = 0xFFFFFF) {
			_radius = radius;
			_color = color;
			_matrix = new Matrix();
			draw();
		}
	}
}
