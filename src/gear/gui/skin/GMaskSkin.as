package gear.gui.skin {
	import gear.gui.core.GScaleMode;
	import gear.gui.core.GPhase;
	import gear.utils.GDrawUtil;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.geom.Rectangle;

	/**
	 * 遮罩皮肤
	 * 
	 * @author bright
	 * @version 20121205
	 */
	public class GMaskSkin implements IGSkin {
		protected var _bitmap : Bitmap;
		protected var _source : Vector.<BitmapData>;
		protected var _target : Vector.<BitmapData>;
		protected var _scale9Grid : Rectangle;
		protected var _selected : Boolean;
		protected var _phase : int;
		protected var _width : int;
		protected var _height : int;
		protected var _mask : Shape;

		protected function update() : void {
			if (_phase == GPhase.NONE) {
				_phase = GPhase.UP;
			}
			var bd : BitmapData = _target[_phase + (_selected ? 4 : 0)];
			if (bd == null) {
				bd = _target[_selected ? GPhase.SELECTED_UP : GPhase.UP];
			}
			_bitmap.bitmapData = bd;
		}

		public function GMaskSkin() {
			_source = new Vector.<BitmapData>(9, true);
			_target = new Vector.<BitmapData>(9, true);
			_bitmap = new Bitmap();
			_phase = GPhase.NONE;
			_mask = new Shape();
			GDrawUtil.drawFillRect(_mask.graphics, 0xFF, 1, 0, 0, 100, 100);
			_bitmap.mask = _mask;
		}

		public function get scaleMode() : int {
			return GScaleMode.SCALE;
		}

		public function set name(value : String) : void {
			_bitmap.name = value;
		}

		public function setAt(phase : int, bitmapData : BitmapData) : void {
			_source[phase] = bitmapData;
			_target[phase] = bitmapData;
			_width = Math.max(_width, bitmapData.width);
			_height = Math.max(_height, bitmapData.height);
		}

		public function addTo(parent : DisplayObjectContainer, index : int = 0) : void {
			if (_bitmap.parent != parent) {
				parent.addChildAt(_bitmap, index);
				parent.addChildAt(_mask, index);
			}
		}

		public function remove() : void {
			if (_bitmap.parent != null) {
				_bitmap.parent.removeChild(_bitmap);
			}
		}

		public function moveTo(x : int, y : int) : void {
			_bitmap.x = x;
			_bitmap.y = y;
		}

		public function set x(value : int) : void {
			_bitmap.x = value;
		}

		public function get x() : int {
			return _bitmap.x;
		}

		public function set y(value : int) : void {
			_bitmap.y = value;
		}

		public function get y() : int {
			return _bitmap.y;
		}

		public function setSize(width : int, height : int) : void {
			if (_width == width && _height == height) {
				return;
			}
			_width = width;
			_height = height;
			var i : int;
			var bd : BitmapData;
			for (i = 0; i < _target.length; i++) {
				bd = _target[i];
				if (bd != null && bd != _source[i]) {
					bd.dispose();
				}
			}
			_mask.width = width;
			_mask.height = height;
			update();
		}

		public function get width() : int {
			return _width;
		}

		public function get height() : int {
			return _height;
		}

		public function set phase(value : int) : void {
			if (_phase == value) {
				return;
			}
			_phase = value;
			update();
		}

		public function set scale9Grid(value : Rectangle) : void {
			_scale9Grid = value;
		}

		public function set selected(value : Boolean) : void {
			if (_selected == value) {
				return;
			}
			_selected = value;
			update();
		}

		public function clone() : IGSkin {
			var result : GPhaseSkin = new GPhaseSkin();
			var bd : BitmapData;
			for (var i : int = 0; i < _source.length; i++) {
				bd = _source[i];
				if (bd != null) {
					result.setAt(i, bd);
				}
			}
			if (_scale9Grid != null) {
				result.scale9Grid = _scale9Grid.clone();
			}
			return result;
		}
	}
}
