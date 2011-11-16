package gear.render {
	import gear.core.IDispose;

	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;

	/**
	 * 位图数据定义
	 * 
	 * @author bright
	 * @version 20111024
	 */
	public class BDList implements IDispose {
		public var key : String;
		protected var _list : Vector.<BDUnit>;
		protected var _total : int;
		protected var _hasFlipH : Boolean;
		protected var _hasShadow : Boolean;
		protected var _matrix : Matrix;
		protected var _flipH_list : Vector.<BDUnit>;
		protected var _shadow_list : Vector.<BDUnit>;
		protected var _flipH_shadow_list : Vector.<BDUnit>;

		protected function createFlipHList() : void {
			if (_flipH_list != null) {
				return;
			}
			var total : int = _list.length;
			_flipH_list = new Vector.<BDUnit>(total, true);
			var unit : BDUnit;
			var bd : BitmapData;
			_matrix.identity();
			_matrix.scale(-1, 1);
			for (var i : int = 0;i < total;i++) {
				unit = _list[i];
				if (unit == null || unit.bd == null) {
					continue;
				}
				bd = new BitmapData(unit.bd.width, unit.bd.height, true, 0);
				_matrix.tx = bd.width;
				bd.draw(unit.bd, _matrix);
				_flipH_list[i] = new BDUnit(-unit.offsetX - bd.width, unit.offsetY, bd);
			}
		}

		protected function createShadowList() : void {
			if (_shadow_list != null) {
				return;
			}
			var total : int = _list.length;
			_shadow_list = new Vector.<BDUnit>(total, true);
			var unit : BDUnit;
			var bd : BitmapData;
			_matrix.identity();
			_matrix.c = 0.4;
			_matrix.d = 0.3;
			var size : Point;
			var offset : Point;
			for (var i : int = 0;i < total;i++) {
				unit = _list[i];
				if (unit == null || unit.bd == null) {
					continue;
				}
				size = _matrix.transformPoint(new Point(unit.bd.width, unit.bd.height));
				offset = _matrix.transformPoint(new Point(unit.offsetX, unit.offsetY));
				bd = new BitmapData(size.x, size.y, true, 0);
				bd.draw(unit.bd, _matrix, new ColorTransform(0, 0, 0, 0.5));
				_shadow_list[i] = new BDUnit(offset.x, offset.y, bd);
			}
		}

		protected function createFlipHShadowList() : void {
			if (_flipH_shadow_list != null) {
				return;
			}
			var total : int = _list.length;
			_flipH_shadow_list = new Vector.<BDUnit>(total, true);
			var unit : BDUnit;
			var bd : BitmapData;
			_matrix.identity();
			_matrix.c = 0.4;
			_matrix.d = 0.3;
			var size : Point;
			var offset : Point;
			for (var i : int = 0;i < total;i++) {
				unit = _flipH_list[i];
				if (unit == null || unit.bd == null) {
					continue;
				}
				size = _matrix.transformPoint(new Point(unit.bd.width, unit.bd.height));
				offset = _matrix.transformPoint(new Point(unit.offsetX, unit.offsetY));
				bd = new BitmapData(size.x, size.y, true, 0);
				bd.draw(unit.bd, _matrix, new ColorTransform(0, 0, 0, 0.5));
				_flipH_shadow_list[i] = new BDUnit(offset.x, offset.y, bd);
			}
		}

		/**
		 * 构造函数
		 * 
		 * @param value 位图数组.
		 */
		public function BDList(value : Vector.<BDUnit>) {
			_list = value;
			_total = _list.length;
			_matrix = new Matrix();
		}

		public function create(hasFlipH : Boolean, hasShadow : Boolean) : void {
			_hasFlipH = hasFlipH;
			_hasShadow = hasShadow;
			if (_hasFlipH) {
				createFlipHList();
			}
			if (_hasShadow) {
				createShadowList();
				if (_hasFlipH) {
					createFlipHShadowList();
				}
			}
		}

		/**
		 * 获得指定帧的位图
		 * 
		 * @param frame 第几帧
		 * @return 位图
		 */
		public function getAt(value : int, flipH : Boolean = false) : BDUnit {
			if (value < 0 || value >= _list.length) {
				return null;
			}
			if (flipH && _hasFlipH) {
				return _flipH_list[value];
			} else {
				return _list[value];
			}
		}

		public function get hasShadow() : Boolean {
			return _hasShadow;
		}

		public function getShadowAt(value : int, flipH : Boolean) : BDUnit {
			if (_hasShadow) {
				if (flipH && _hasFlipH) {
					return _flipH_shadow_list[value];
				} else {
					return _shadow_list[value];
				}
			} else {
				return null;
			}
		}

		/**
		 * 获得总帧数
		 * 
		 * @return 总帧数
		 */
		public function get total() : int {
			return _total;
		}

		/**
		 * @inheritDoc
		 */
		public function dispose() : void {
			if (_list == null) {
				return;
			}
			for each (var unit:BDUnit in _list) {
				unit.dispose();
			}
			_list = null;
		}
	}
}