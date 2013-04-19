package gear.gui.utils {
	import gear.gui.core.GPhase;
	import gear.gui.skin.GPhaseSkin;
	import gear.gui.skin.IGSkin;
	import gear.gui.skin.theme.GASTheme;
	import gear.gui.skin.theme.IGTheme;
	import gear.log4a.GLogger;
	import gear.utils.GBDUtil;

	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.system.Capabilities;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	/**
	 * UI管理器
	 * 
	 * @author bright
	 * @version 20130309
	 */
	public final class GUIUtil {
		// 默认字体
		public static var defaultFont : String = "Tahoma";
		// 默认字体尺寸
		public static var defaultFontSize : int = 12;
		// 默认主题
		public static var theme : IGTheme = new GASTheme();
		// 默认样式
		private static var _defaultCSS : StyleSheet;
		private static var _stage : Stage;

		/**
		 * 设置根
		 * 
		 * @param value 根
		 */
		public static function init(value : Stage) : void {
			if (_stage != null) {
				return;
			}
			_stage = value;
			_stage.scaleMode = StageScaleMode.NO_SCALE;
			_stage.align = StageAlign.TOP_LEFT;
			_stage.quality = StageQuality.HIGH;
			_stage.stageFocusRect = false;
			var os : String = Capabilities.os;
			if (os.indexOf("Windows") != -1) {
				defaultFont = "Tahoma";
			} else if (os.indexOf("Mac") != -1) {
				defaultFont = "冬青黑体简体中文 W3";
			} else if (os.indexOf("Linux") != -1) {
				defaultFont = "AR PL UMing CN";
			} else if (os.indexOf("iPhone OS")) {
			}
		}

		public static function get stage() : Stage {
			return _stage;
		}

		/**
		 * 获得默认样式
		 * 
		 * @return 样式
		 */
		public static function get defaultCSS() : StyleSheet {
			if (_defaultCSS == null) {
				_defaultCSS = new StyleSheet();
				_defaultCSS.setStyle(".font", {fontFamily:defaultFont});
			}
			return _defaultCSS;
		}

		public static function getTextFormat() : TextFormat {
			var textFormat : TextFormat = new TextFormat();
			textFormat.font = defaultFont;
			textFormat.size = defaultFontSize;
			textFormat.leading = 3;
			textFormat.kerning = true;
			return textFormat;
		}

		public static function getTextField() : TextField {
			var textField : TextField = new TextField();
			textField.defaultTextFormat = getTextFormat();
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.selectable = false;
			return textField;
		}

		public static function getInputTextField() : TextField {
			var textField : TextField = new TextField();
			textField.defaultTextFormat = getTextFormat();
			textField.condenseWhite = true;
			textField.tabEnabled = true;
			textField.type = TextFieldType.INPUT;
			textField.width = textField.textWidth + 3;
			textField.height = textField.textHeight+1;
			return textField;
		}

		public static function toSkin(value : DisplayObject) : IGSkin {
			if (value is SimpleButton) {
				var skin : IGSkin = new GPhaseSkin();
				var simpleButton : SimpleButton = SimpleButton(value);
				skin.setAt(GPhase.UP, GBDUtil.toBD(simpleButton.upState));
				skin.setAt(GPhase.OVER, GBDUtil.toBD(simpleButton.overState));
				skin.setAt(GPhase.DOWN, GBDUtil.toBD(simpleButton.downState));
				return skin;
			}
			return null;
		}

		public static function setFullScreen(value : Boolean) : void {
			if (_stage == null) {
				return;
			}
			if (value == (_stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE)) {
				return;
			}
			try {
				if (value) {
					_stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
				} else {
					_stage.displayState = StageDisplayState.NORMAL;
				}
			} catch(e : SecurityError) {
				GLogger.debug(e.getStackTrace());
			}
		}
	}
}