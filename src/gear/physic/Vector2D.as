package gear.physic {
	public class Vector2D {
		public var x : Number;
		public var y : Number;

		public function Vector2D(x : Number = 0, y : Number = 0) {
			this.x = x;
			this.y = y;
		}

		public function copy() : Vector2D {
			return new Vector2D(x, y);
		}

		public function get angle() : Number {
			return Math.atan2(y, x);
		}

		public function set angle(value : Number) : void {
			x = length * Math.cos(value);
			y = length * Math.sin(value);
		}

		public function rotate(angle : Number) : void {
			var ca : Number = Math.cos(angle);
			var sa : Number = Math.sin(angle);

			x = x * ca - y * sa;
			y = x * sa + y * ca;
		}

		public function scaleEquals(value : Number) : void {
			x *= value;
			y *= value;
		}

		public function scale(value : Number) : Vector2D {
			return new Vector2D(x * value, y * value);
		}

		public function get normal() : Vector2D {
			return new Vector2D(-y, x);
		}
		
		public function set length(value : Number) : void {
			this.scaleEquals(value / length);
		}

		public function plusEquals(vector : Vector2D) : void {
			x += vector.x;
			y += vector.y;
		}

		public function plus(vector : Vector2D) : Vector2D {
			return new Vector2D(x + vector.x, y + vector.y);
		}

		public function minusEquals(vector : Vector2D) : void {
			x -= vector.x;
			y -= vector.y;
		}

		public function minus(vector : Vector2D) : Vector2D {
			return new Vector2D(x - vector.x, y - vector.y);
		}

		public function get length() : Number {
			return Math.sqrt((x * x) + (y * y));
		}

		public function toString() : String {
			return "[" + x + ", " + y + "]";
		}
	}
}