package gear.ui.color {
	/**
	 * 亮度,对比度,饱和度,色相
	 * 
	 * @author bright
	 * @version 20120424
	 */
	public final class AdjustColor {
		private var _brightness : int;
		private var _contrast : int;
		private var _saturation : int;
		private var _hue : int;

		public function AdjustColor(brightness : int = 0, contrast : int = 0, saturation : int = 0, hue : int = 0) : void {
			_brightness = brightness;
			_contrast = contrast;
			_saturation = saturation;
			_hue = hue;
		}

		public function get brightness() : int {
			return _brightness;
		}

		public function get contrast() : int {
			return _contrast;
		}

		public function get saturation() : int {
			return _saturation;
		}

		public function get hue() : int {
			return _hue;
		}

		public function reset(brightness : int, contrast : int, saturation : int, hue : int) : void {
			_brightness = brightness;
			_contrast = contrast;
			_saturation = saturation;
			_hue = hue;
		}

		public function get isEmpty() : Boolean {
			if (_brightness != 0) {
				return false;
			}
			if (_contrast != 0) {
				return false;
			}
			if (_saturation != 0) {
				return false;
			}
			if (_hue != 0) {
				return false;
			}
			return true;
		}

		public function toString() : String {
			return _brightness + "," + _contrast + "," + _saturation + "," + _hue;
		}
	}
}
