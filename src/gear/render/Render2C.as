package gear.render {
	import gear.log4a.LogError;

	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;

	/**
	 * @author Administrator
	 */
	public class Render2C {
		protected var _parent : RenderList;
		protected var _x : int;
		protected var _y : int;
		protected var _dest : Point;
		protected var _alpha : Number;
		protected var _scaleX : Number;
		protected var _scaleY : Number;
		protected var _flipH : Boolean;
		protected var _matrix : Matrix;
		protected var _ctf : ColorTransform;
		protected var _filters : Array;
		protected var _source : *;

		public function Render2C() : void {
			_alpha = 1;
			_scaleX = _scaleY = 1;
			_dest = new Point();
			_matrix = new Matrix();
			_ctf = new ColorTransform();
			_flipH = false;
		}

		public function set parent(value : RenderList) : void {
			_parent = value;
		}

		public function set x(value : int) : void {
			_x = value;
		}

		public function get x() : int {
			return _x;
		}

		public function set y(value : int) : void {
			_y = value;
		}

		public function get y() : int {
			return _y;
		}

		public function set alpha(value : Number) : void {
			if (_alpha == value) {
				return;
			}
			_alpha = value;
			_ctf.alphaMultiplier = value;
		}

		public function get alpha() : Number {
			return _alpha;
		}

		public function set scale(value : Number) : void {
			_scaleX = _scaleY = value;
		}

		public function get scaleX() : Number {
			return _scaleX;
		}

		public function get scaleY() : Number {
			return _scaleY;
		}

		public function set filters(value : Array) : void {
			_filters = value;
		}

		public function set flipH(value : Boolean) : void {
			_flipH = value;
		}

		public function get flipH() : Boolean {
			return _flipH;
		}

		public function get matrix() : Matrix {
			return _matrix;
		}

		public function moveTo(newX : int, newY : int) : void {
			_x = newX;
			_y = newY;
		}

		public function show() : void {
			if (_parent != null) {
				_parent.add(this);
			}
		}

		public function hide() : void {
			if (_parent != null) {
				_parent.remove(this);
			}
		}

		public function set source(value : *) : void {
			_source = value;
		}

		public function get source() : * {
			return _source;
		}

		public function render(target : BitmapData, cx : int, cy : int) : void {
			throw new LogError("CRender.render is abstract Function!");
		}
	}
}
