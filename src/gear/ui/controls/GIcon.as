package gear.ui.controls {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	
	import gear.ui.core.GBase;
	import gear.ui.core.GScaleMode;
	import gear.ui.data.GIconData;
	import gear.utils.ColorMatrixUtil;

	/**
	 * 图标控件
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class GIcon extends GBase {
		/**
		 * @private
		 */
		protected var _data : GIconData;
		/**
		 * @private
		 */
		protected var _bitmap : Bitmap;
		/**
		 * @private
		 */
		protected var _bd : BitmapData;
		/**
		 * @private
		 */
		protected var _flipH : Boolean = false;
		/**
		 * @private
		 */
		protected var _offset : Point = new Point(0, 0);

		/**
		 * @private
		 */
		override protected function create() : void {
			_bitmap = new Bitmap();
			addChild(_bitmap);
			bitmapData = _data.bitmapData;
		}

		/**
		 * @inheritDoc
		 */
		public function GIcon(data : GIconData) {
			_data = data;
			super(data);
		}

		public function get bitmapData() : BitmapData {
			return _bd;
		}

		/**
		 * 设置图标位图
		 * 
		 * @param value 位图
		 */
		public function set bitmapData(value : BitmapData) : void {
			_bd = value;
			if (_bd != null) {
				_bitmap.bitmapData = _bd;
				_bitmap.smoothing = true;
				if (_data.scaleMode == GScaleMode.AUTO_SIZE) {
					_width = _bd.width - 1;
					_height = _bd.height - 1;
				} else {
					_bitmap.width = _width;
					_bitmap.height = _height;
				}
			} else {
				_bitmap.bitmapData = null;
			}
			var scaleX : Number = (_bitmap.scaleX > 0 ? _bitmap.scaleX : -_bitmap.scaleX);
			if (_flipH) {
				_bitmap.scaleX = -scaleX;
				_bitmap.x = _offset.x + _bitmap.width;
			} else {
				_bitmap.scaleX = scaleX;
				_bitmap.x = _offset.x;
			}
		}

		/**
		 * @param value 是否为灰度
		 */
		public function set gray(value : Boolean) : void {
			filters = (value ? [new ColorMatrixFilter(ColorMatrixUtil.GRAY)] : null);
		}

		/**
		 * 设置偏移
		 * 
		 * @param offset 偏移
		 */
		public function set offset(offset : Point) : void {
			_offset = offset.clone();
			_bitmap.x = (_flipH ? _offset.x + _bitmap.width : _offset.x);
			_bitmap.y = _offset.y;
		}

		/**
		 * 设置水平翻转
		 * 
		 * @param flipH 是否水平翻转
		 */
		public function setFlipH(flipH : Boolean) : void {
			_flipH = flipH;
		}

		/**
		 * 克隆
		 * 
		 * @return 图标控件
		 */
		public function clone() : GIcon {
			var data : GIconData = _data.clone();
			data.bitmapData = _bd;
			var icon : GIcon = new GIcon(data);
			return icon;
		}
	}
}