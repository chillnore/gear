package gear.particle.core {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;

	public class Particle {
		public var collisionRadius : Number;
		public var mass : Number;
		public var image : IBitmapDrawable;
		public var lifetime : Number;
		public var age : Number;
		public var energy : Number;
		protected var _x : Number;
		protected var _y : Number;
		protected var _oldX : Number;
		protected var _oldY : Number;
		protected var _scale : Number;
		protected var _speedX : Number;
		protected var _speedY : Number;
		protected var _rotation : Number;
		protected var _lifetime : int;
		protected var _color : uint;
		protected var _oldColor : uint;
		protected var _ctf : ColorTransform;
		protected var _isDead : Boolean;
		protected var _matrix : Matrix;
		protected var _image : DisplayObject;
		protected var _buffer : BitmapData;

		public function Particle() {
			reset();
			_matrix = new Matrix();
			_ctf = new ColorTransform();
			_ctf.redMultiplier = ((color >>> 16) & 255) / 255;
			_ctf.greenMultiplier = ((color >>> 8) & 255) / 255;
			_ctf.blueMultiplier = ((color) & 255) / 255;
			_ctf.alphaMultiplier = ((color >>> 24) & 255) / 255;
		}

		public function reset() : void {
			collisionRadius = 1;
			_oldX = _x = 0;
			_oldY = _y = 0;
			_speedX = 0;
			_speedY = 0;
			_scale = 1;
			_rotation = 0;
			_oldColor = _color = 0xFFFFFFFF;
			mass = 0;
			lifetime = 0;
			age = 0;
			energy = 1;
			_isDead = false;
			image = null;
		}

		public function set x(value : Number) : void {
			_oldX = _x;
			_x = value;
		}

		public function get x() : Number {
			return _x;
		}

		public function set y(value : Number) : void {
			_oldY = _y;
			_y = value;
		}

		public function get y() : Number {
			return _y;
		}

		public function get oldX() : Number {
			return _oldX;
		}

		public function get oldY() : Number {
			return _oldY;
		}

		public function set scale(value : Number) : void {
			if (_scale == value) {
				return;
			}
			_scale = value;
		}

		public function set speedX(value : Number) : void {
			_speedX = value;
		}

		public function get speedX() : Number {
			return _speedX;
		}

		public function set speedY(value : Number) : void {
			_speedY = value;
		}

		public function get speedY() : Number {
			return _speedY;
		}

		public function set rotation(value : Number) : void {
			_rotation = value;
		}

		public function get rotation() : Number {
			return _rotation;
		}

		public function set color(value : uint) : void {
			_color = value;
			_ctf.redMultiplier = ((color >>> 16) & 255) / 255;
			_ctf.greenMultiplier = ((color >>> 8) & 255) / 255;
			_ctf.blueMultiplier = ((color) & 255) / 255;
			_ctf.alphaMultiplier = ((color >>> 24) & 255) / 255;
			_oldColor = color;
		}

		public function get color() : uint {
			return _color;
		}

		public function moveTo(nx : int, ny : int) : void {
			_oldX = _x;
			_x = nx;
			_oldY = _y;
			_y = ny;
		}

		public function set isDead(value : Boolean) : void {
			_isDead = value;
		}

		public function get isDead() : Boolean {
			return _isDead;
		}

		public function render(target : BitmapData, cx : int, cy : int) : void {
			_matrix.identity();
			_matrix.scale(_scale, _scale);
			_matrix.tx = x + cx;
			_matrix.ty = y + cy;
			target.draw(image, _matrix, _ctf, null, null, true);
		}
	}
}