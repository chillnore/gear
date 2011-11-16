package gear.ui.data {
	import gear.net.AssetData;
	import gear.ui.core.GBaseData;
	import gear.ui.manager.UIManager;

	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @version 20100325
	 * @author bright
	 */
	public class GTextAreaData extends GBaseData {
		public var bgAsset : AssetData = new AssetData("GTextArea_bgSkin");
		/**
		 * 绑定文本
		 */
		public var textField : TextField;
		public var textFormat : TextFormat;
		public var styleSheet : StyleSheet;
		public var textColor : uint;
		public var textFieldFilters : Array;
		public var padding : int = 2;
		public var editable : Boolean = true;
		public var selectable : Boolean = true;
		public var maxLines : int = 0;
		public var edlim : String;
		public var maxChars : int = 0;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GTextAreaData = source as GTextAreaData;
			if (data == null) {
				return;
			}
			data.bgAsset = bgAsset;
			data.textFormat = textFormat;
			data.styleSheet = styleSheet;
			data.textColor = textColor;
			data.textFieldFilters = (textFieldFilters != null ? textFieldFilters.concat() : null);
			data.padding = padding;
			data.editable = editable;
			data.selectable = selectable;
			data.maxLines = maxLines;
			data.edlim = edlim;
		}

		public function GTextAreaData() {
			textColor = 0xFFFFFF;
			textFieldFilters = UIManager.getEdgeFilters(0x000000, 0.7);
			textFormat = new TextFormat();
			textFormat.font = UIManager.defaultFont;
			textFormat.size = 12;
			textFormat.leading = 2;
			textFormat.kerning = true;
			styleSheet = UIManager.defaultCSS;
			width = 104;
			height = 104;
		}

		public function bindTo(tf : TextField) : void {
			if (tf == null) {
				return;
			}
			x += Math.round(tf.x);
			y += Math.round(tf.y);
			tf.x = 0;
			tf.y = 0;
			tf.text = "";
			width = Math.round(tf.width) + padding * 2;
			height = Math.round(tf.height) + padding * 2;
			textField = tf;
		}

		override public function clone() : * {
			var data : GTextAreaData = new GTextAreaData();
			parse(data);
			return data;
		}
	}
}
