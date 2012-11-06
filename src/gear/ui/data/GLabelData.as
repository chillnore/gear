package gear.ui.data {
	import gear.ui.core.GBaseData;
	import gear.ui.manager.GUIUtil;

	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * 标签控件定义
	 * 
	 * @author bright
	 * @version 20120815
	 */
	public class GLabelData extends GBaseData {
		/**
		 * 图标控件定义
		 */
		public var iconData : GIconData ;
		/**
		 * 绑定文本
		 */
		public var textField : TextField;
		/**
		 * 图标Y坐标
		 */
		public var iconY : int = 0;
		/**
		 * 色彩定义
		 */
		public var color : GStateColor;
		/**
		 * 文本滤镜数组
		 */
		public var textFieldFilters : Array;
		/**
		 * 文本透明度
		 */
		public var textFieldAlpha : Number;
		/**
		 * 文本格式化
		 */
		public var textFormat : TextFormat;
		/**
		 * 文本样式表
		 */
		public var styleSheet : StyleSheet;
		/**
		 * 水平间隙
		 */
		public var hGap : int;
		/**
		 * 文本
		 */
		public var text : String;
		/**
		 * HTML文本
		 */
		public var htmlText : String;
		/**
		 * 最大长度
		 */
		public var maxLength : int;

		/**
		 * @private
		 */
		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GLabelData = source as GLabelData;
			if (data == null) {
				return;
			}
			data.iconData = iconData.clone();
			data.iconY = iconY;
			data.color = color.clone();
			data.textFieldFilters = (textFieldFilters != null ? textFieldFilters.concat() : null);
			data.textFormat = textFormat;
			data.styleSheet = styleSheet;
			data.hGap = hGap;
			data.text = text;
			data.htmlText = htmlText;
		}

		public function GLabelData() {
			iconData = new GIconData();
			color = new GStateColor();
			color.upColor = 0xEFEFEF;
			color.overColor = 0xEFEFEF;
			color.downColor = 0xEFEFEF;
			color.selectedColor = 0xEFEFEF;
			color.disabledColor = 0xEFEFEF;
			textFormat = new TextFormat();
			textFormat.font = GUIUtil.defaultFont;
			textFormat.size = GUIUtil.defaultSize;
			textFormat.leading = 3;
			textFormat.kerning = true;
			styleSheet = GUIUtil.defaultCSS;
			hGap = 1;
			text = "";
			htmlText = "";
			maxLength = 0;
		}

		/**
		 * 绑定TextFiled到标签控件文本
		 * 
		 * @param value TextField
		 */
		public function bindTo(tf : TextField) : void {
			if (tf == null) {
				return;
			}
			x += Math.round(tf.x);
			y += Math.round(tf.y);
			tf.x = 0;
			tf.y = 0;
			tf.text = "";
			textField = tf;
		}

		/**
		 * @inheritDoc
		 */
		override public function clone() : * {
			var data : GLabelData = new GLabelData();
			parse(data);
			return data;
		}
	}
}
