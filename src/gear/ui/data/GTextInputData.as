package gear.ui.data {
	import flash.display.DisplayObject;

	import gear.net.AssetData;
	import gear.ui.core.GBaseData;
	import gear.ui.manager.UIManager;
	import gear.ui.skin.SkinStyle;

	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * 输入框控件定义
	 * 
	 * @author bright
	 * @version 20101025
	 * 
	 * 尝试加入defaultText属性，当获得输入焦点时移除
	 */
	public class GTextInputData extends GBaseData {
		public var borderSkin : DisplayObject;
		public var disabledSkin : DisplayObject;
		public var borderAsset : AssetData = new AssetData("GTextInput_borderSkin");
		public var disabledAsset : AssetData = new AssetData("GTextInput_disabledSkin");
		/**
		 * 绑定文本
		 */
		public var textField : TextField;
		public var textFormat : TextFormat;
		public var color : GColor;
		public var textFieldFilters : Array;
		public var maxChars : int = 0;
		public var displayAsPassword : Boolean = false;
		public var restrict : String = "";
		public var allowIME : Boolean = true;
		public var text : String = "";

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GTextInputData = source as GTextInputData;
			if (data == null) {
				return;
			}
			data.borderAsset = borderAsset;
			data.textFormat = textFormat;
			data.color = color.clone();
			data.textFieldFilters = (textFieldFilters != null ? textFieldFilters.concat() : null);
			data.maxChars = maxChars;
			data.displayAsPassword = displayAsPassword;
			data.restrict = restrict;
			data.allowIME = allowIME;
			data.text = text;
		}

		public function GTextInputData() {
			width = 103;
			height = 22;
			textFormat = new TextFormat();
			textFormat.font = UIManager.defaultFont;
			textFormat.size = UIManager.defaultSize;
			textFormat.kerning = true;
			color = new GColor();
			color.upColor = 0xEFEFEF;
			color.downColor = 0xEFEFEF;
			color.selectedColor = 0xEFEFEF;
			color.disabledColor = 0x898989;
		}

		public function bindTo(tf : TextField) : void {
			if (tf == null) {
				return;
			}
			x = Math.round(tf.x);
			y = Math.round(tf.y);
			tf.x = 0;
			tf.y = 0;
			tf.text = "";
			tf.multiline = false;
			textField = tf;
			borderAsset = new AssetData(SkinStyle.emptySkin, AssetData.AS_LIB);
		}

		override public function clone() : * {
			var data : GTextInputData = new GTextInputData();
			parse(data);
			return data;
		}
	}
}
