package gear.ui.cell {
	/**
	 * LabelSource 标签数据源 
	 *
	 * @author bright
	 * @version 20101015
	 */
	public final class LabelSource {
		private var _text : String;
		private var _value : *;

		/**
		 * @param text 文本
		 * @param value 值
		 */
		public function LabelSource(text : String, value : *= null) {
			_text = text;
			_value = value;
		}

		/**
		 * @return 文本
		 */
		public function get text():String {
			return _text;
		}

		/**
		 * @return 值
		 */
		public function get value():* {
			return _value;
		}

		/**
		 * @return 文本
		 */
		public function toString():String {
			return _text;
		}
	}
}
