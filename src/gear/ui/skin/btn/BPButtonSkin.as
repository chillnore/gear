package gear.ui.skin.btn {
	import gear.ui.core.PhaseState;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;

	/**
	 * 位图按钮皮肤
	 * 
	 * upSkin 正常 必选
	 * overSkin 鼠标滑入 可选
	 * downSkin 鼠标按下 可选
	 * 
	 * @author bright
	 * @version 20120809
	 */
	public class BPButtonSkin implements IButtonSkin {
		private var _bitmap : Bitmap;
		private var _upSkin : BitmapData;
		private var _overSkin : BitmapData;
		private var _downSkin : BitmapData;

		public function BPButtonSkin(upSkin : BitmapData, overSkin : BitmapData = null, downSkin : BitmapData = null) {
			_upSkin = upSkin;
			_overSkin = overSkin;
			_downSkin = downSkin;
			_bitmap = new Bitmap();
			_bitmap.bitmapData = _upSkin;
		}

		public function addTo(parent : DisplayObjectContainer) : void {
			if (_bitmap.parent != parent) {
				parent.addChild(_bitmap);
			}
		}

		public function setSize(width : int, height : int) : void {
		}

		public function get width() : int {
			return _bitmap.width;
		}

		public function get height() : int {
			return _bitmap.height;
		}

		public function set phase(value : int) : void {
			switch(value) {
				case PhaseState.UP:
					_bitmap.bitmapData = _upSkin;
					break;
				case PhaseState.OVER:
					if (_overSkin != null) {
						_bitmap.bitmapData = _overSkin;
					}
					break;
				case PhaseState.DOWN:
					if (_downSkin != null) {
						_bitmap.bitmapData = _downSkin;
					}
					break;
				case PhaseState.DISABLED:
					break;
			}
		}

		public function clone() : IButtonSkin {
			return new BPButtonSkin(_upSkin, _overSkin, _downSkin);
		}
	}
}
