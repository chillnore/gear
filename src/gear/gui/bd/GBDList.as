package gear.gui.bd {
	import gear.core.IDispose;
	import gear.utils.GColorMatrixUtil;

	import flash.display.BitmapData;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * 位图数据定义
	 * 
	 * @author bright
	 * @version 20130527
	 */
	public final class GBDList implements IDispose {
		public var key : String;
		private var _list : Vector.<GBDFrame>;
		private var _hasFlipH : Boolean;
		private var _hasShadow : Boolean;
		private var _matrix : Matrix;
		private var _flipH_list : Vector.<GBDFrame>;
		private var _shadow_list : Vector.<GBDFrame>;
		private var _flipH_shadow_list : Vector.<GBDFrame>;
		private var _rect : Rectangle;

		private function createFlipHList() : void {
			if (_flipH_list != null) {
				return;
			}
			var total : int = _list.length;
			_flipH_list = new Vector.<GBDFrame>(total, true);
			var unit : GBDFrame;
			var bd : BitmapData;
			_matrix.identity();
			_matrix.scale(-1, 1);
			for (var i : int = 0; i < total; i++) {
				unit = _list[i];
				if (unit == null || unit.bd == null) {
					continue;
				}
				bd = new BitmapData(unit.bd.width, unit.bd.height, true, 0);
				_matrix.tx = bd.width;
				bd.draw(unit.bd, _matrix);
				_flipH_list[i] = new GBDFrame(-unit.offsetX - bd.width, unit.offsetY, bd);
			}
		}

		private function createShadowList() : void {
			if (_shadow_list != null) {
				return;
			}
			var total : int = _list.length;
			_shadow_list = new Vector.<GBDFrame>(total, true);
			var unit : GBDFrame;
			var bd : BitmapData;
			_matrix.identity();
			_matrix.c = 0.35;
			_matrix.d = 0.45;
			var size : Point;
			var offset : Point;
			for (var i : int = 0; i < total; i++) {
				unit = _list[i];
				if (unit == null || unit.bd == null) {
					continue;
				}
				size = _matrix.transformPoint(new Point(unit.bd.width, unit.bd.height));
				offset = _matrix.transformPoint(new Point(unit.offsetX, unit.offsetY));
				if (size.y < 1) {
					size.y = 1;
				}
				bd = new BitmapData(size.x, size.y, true, 0);
				bd.draw(unit.bd, _matrix, new ColorTransform(0, 0, 0, 0.5));
				_shadow_list[i] = new GBDFrame(offset.x, offset.y, bd);
			}
		}

		private function createFlipHShadowList() : void {
			if (_flipH_shadow_list != null) {
				return;
			}
			var total : int = _list.length;
			_flipH_shadow_list = new Vector.<GBDFrame>(total, true);
			var unit : GBDFrame;
			var bd : BitmapData;
			_matrix.identity();
			_matrix.c = 0.35;
			_matrix.d = 0.45;
			var size : Point;
			var offset : Point;
			for (var i : int = 0; i < total; i++) {
				unit = _flipH_list[i];
				if (unit == null || unit.bd == null) {
					continue;
				}
				size = _matrix.transformPoint(new Point(unit.bd.width, unit.bd.height));
				offset = _matrix.transformPoint(new Point(unit.offsetX, unit.offsetY));
				if (size.y < 1) {
					size.y = 1;
				}
				bd = new BitmapData(size.x, size.y, true, 0);
				bd.draw(unit.bd, _matrix, new ColorTransform(0, 0, 0, 0.5));
				_flipH_shadow_list[i] = new GBDFrame(offset.x, offset.y, bd);
			}
		}

		/**
		 * 构造函数
		 * 
		 * @param value 位图数组.
		 */
		public function GBDList(value : Vector.<GBDFrame>=null) {
			if (value == null) {
				value = new Vector.<GBDFrame>();
			}
			_list = value;
			_matrix = new Matrix();
			_hasShadow = false;
			_hasFlipH = false;
			_hasShadow = false;
		}

		public function set scale(value : Number) : void {
			for each (var unit : GBDFrame in _list) {
				unit.scale = value;
			}
		}

		public function create(hasFlipH : Boolean, hasShadow : Boolean) : void {
			_hasFlipH = hasFlipH;
			_hasShadow = hasShadow;
			if (_hasFlipH) {
				createFlipHList();
			}
			if (_hasShadow ) {
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
		public function getAt(value : int, flipH : Boolean = false) : GBDFrame {
			if (value < 0 || value >= _list.length) {
				return null;
			}
			if (flipH && _hasFlipH) {
				return _flipH_list[value];
			} else {
				return _list[value];
			}
		}

		public function setAt(index : int, unit : GBDFrame) : void {
			if (_list.length < index) {
				_list.length = index;
			}
			_list[index] = unit;
		}

		public function get hasFlipH() : Boolean {
			return _hasFlipH;
		}

		public function get hasShadow() : Boolean {
			return _hasShadow;
		}

		public function getShadowAt(value : int, flipH : Boolean) : GBDFrame {
			if (!_hasShadow) {
				return null;
			}
			if (!flipH) {
				if (_shadow_list != null) {
					return _shadow_list[value];
				}
			} else {
				if (_flipH_shadow_list != null) {
					return _flipH_shadow_list[value];
				}
			}
			return null;
		}

		public function set length(value : int) : void {
			_list.length = value;
		}

		/**
		 * 获得总帧数
		 * 
		 * @return 总帧数
		 */
		public function get length() : int {
			return _list.length;
		}

		/**人
		 * @inheritDoc
		 */
		public function dispose() : void {
			if (_list == null) {
				return;
			}
			for each (var unit : GBDFrame in _list) {
				unit.dispose();
			}
			_list = null;
		}

		private function getMaxRect() : void {
			_rect = new Rectangle();
			if (_list) {
				for each (var data : GBDFrame in _list) {
					var bdw : int = data.offsetX + data.bd.width;
					var bdh : int = data.offsetY + data.bd.height;
					if (bdw > _rect.width) _rect.width = bdw;
					if (bdh > _rect.height) _rect.height = bdh;
				}
			}
		}

		public function alpha(value : Number) : void {
			var bd : BitmapData;
			for (var i : int = 0; i < _list.length; i++) {
				bd = _list[i].bd;
				var ct : ColorTransform = new ColorTransform(1.0, 1.0, 1.0, value);
				bd.colorTransform(bd.rect, ct);
				_list[i] = new GBDFrame(_list[i].offsetX, _list[i].offsetY, bd);
			}
		}

		/**
		 * 调整亮度,对比度,饱和度,色相
		 */
		public function adjustColor(brightness : int, contrast : int, saturation : int, hue : int) : void {
			var point : Point = new Point(0, 0);
			var colorMatrixFilter : ColorMatrixFilter = new ColorMatrixFilter();
			colorMatrixFilter.matrix = GColorMatrixUtil.adjustColor(brightness, contrast, saturation, hue);
			var bd : BitmapData;
			for (var i : int = 0; i < _list.length; i++) {
				bd = _list[i].bd;
				bd.applyFilter(bd, bd.rect, point, colorMatrixFilter);
			}
			if (_flipH_list) {
				for (var j : int = 0; j < _flipH_list.length; j++) {
					bd = _flipH_list[j].bd;
					bd.applyFilter(bd, bd.rect, point, colorMatrixFilter);
				}
			}
		}

		public function get maxHeight() : int {
			if (_rect == null) getMaxRect();
			return _rect.height;
		}

		public function get maxWidth() : int {
			if (_rect == null) getMaxRect();
			return _rect.width;
		}

		public function get list() : Vector.<GBDFrame> {
			return _list;
		}

		public function concat(...args : Array) : void {
		}

		public function clone() : GBDList {
			var bds : Vector.<GBDFrame>=new  Vector.<GBDFrame>;
			for (var i : int = 0; i < _list.length; i++) {
				var bdunit : GBDFrame = _list[i].clone();
				bds.push(bdunit);
			}
			return new GBDList(bds);
		}
	}
}