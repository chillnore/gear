package gear.particle.shape {
	import flash.display.Shape;

	/**
	 * @author Administrator
	 */
	public class Ring extends Shape {
		protected var _innerRadius : Number;
		protected var _outerRadius : Number;
		protected var _color : uint;

		protected function draw() : void {
			graphics.clear();
			graphics.beginFill(_color);
			graphics.drawCircle(0, 0, _outerRadius);
			graphics.drawCircle(0, 0, _innerRadius);
			graphics.endFill();
		}

		public function Ring(inner : Number = 1, outer : Number = 2, color : uint = 0xFFFFFF) {
			_innerRadius = inner;
			_outerRadius = outer;
			_color = color;
			draw();
		}
	}
}
