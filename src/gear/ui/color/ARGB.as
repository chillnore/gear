package gear.ui.color {
	/**
	 * ARGB 色彩模型
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public final class ARGB {
		private var _alpha : int;
		private var _red : Number;
		private var _green : Number;
		private var _blue : Number;

		/**
		 * ARGB
		 * 
		 * @param alpha 透明度
		 * @param red 红
		 * @param green 绿
		 * @param blue 蓝
		 */
		public function ARGB(alpha : int = 0, red : int = 0, green : int = 0, blue : int = 0) {
			_alpha = Math.max(0, Math.min(256, alpha));
			_red = Math.max(0, Math.min(256, red));
			_green = Math.max(0, Math.min(256, green));
			_blue = Math.max(0, Math.min(256, blue));
		}

		/**
		 * @return 透明度 0-256
		 */
		public function get alpha():int {
			return _alpha;
		}

		/**
		 * @return 红色 0-256
		 */
		public function get red():int {
			return _red;
		}

		/**
		 * @return 绿色 0-256
		 */
		public function get green():int {
			return _green;
		}

		/**
		 * @return 蓝色 0-256
		 */
		public function get blue():int {
			return _blue;
		}

		/**
		 * ARGB转换成十六进制
		 * 
		 * @example
		 * <listing version="3.0">
		 * trace(new ARGB(0,0xFF,0,0).toHex()); // 输出"0xFF0000"
		 * </listing>
		 */
		public function toHex():uint {
			return _alpha << 24 | _red << 16 | _green << 8 | _blue;
		}

		/**
		 * @return 转换后的字符串
		 */
		public function toString():String {
			return "#" + toHex().toString(16);
		}

		/*
		 * @return 从HEX中生成ARGB
		 */
		public function parse(hex : uint):void {
			_alpha = (hex >> 24) & 0xFF;
			_red = (hex >> 16) & 0xFF;
			_green = (hex >> 8) & 0xFF;
			_blue = hex & 0xFF;
		}
	}
}
