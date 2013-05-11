package gear.gui.controls {
	import gear.utils.GNameUtil;
	import gear.utils.GBDUtil;
	import gear.gui.core.GBase;
	import gear.gui.core.GScaleMode;

	import flash.display.Bitmap;
	import flash.display.BitmapData;

	/**
	 * 图标控件
	 * 
	 * @author bright
	 * @version 20121204
	 */
	public class GIcon extends GBase {
		protected var _bitmap : Bitmap;
		protected var _bitmapData : BitmapData;
		protected var _scale9Grid : BitmapData;

		override protected function preinit() : void {
			_scaleMode = GScaleMode.FIT_SIZE;
		}

		override protected function create() : void {
			_bitmap = new Bitmap();
			_bitmap.name=GNameUtil.createUniqueName(_bitmap);
			addChild(_bitmap);
		}

		protected function refresh() : void {
			if (_scaleMode == GScaleMode.SCALE) {
				_bitmapData = GBDUtil.resizeBD(_bitmapData, _width, _height);
			}
			_bitmap.bitmapData = _bitmapData;
		}

		public function GIcon() {
		}

		public function set bitmapData(value : BitmapData) : void {
			if (_bitmapData == value) {
				return;
			}
			_bitmapData = value;
			if (_scaleMode == GScaleMode.FIT_SIZE) {
				_width = (_bitmapData != null ? _bitmapData.width : 0);
				_height = (_bitmapData != null ? _bitmapData.height : 0);
			}
			callLater(refresh);
		}
	}
}
