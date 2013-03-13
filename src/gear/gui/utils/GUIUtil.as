package gear.gui.utils {
	import gear.gui.skin.theme.GASTheme;
	import gear.gui.skin.theme.IGTheme;
	import gear.log4a.GLogger;
	import gear.utils.GMathUtil;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.getQualifiedClassName;

	/**
	 * UI管理器
	 * 
	 * @author bright
	 * @version 20130309
	 */
	public final class GUIUtil {
		public static const SHADOW : DropShadowFilter = new DropShadowFilter(1, 45, 0, 0.5, 1, 1);
		public static var defaultFont : String = "Tahoma";
		// 默认字体尺寸
		public static var defaultFontSize : int = 12;
		// 默认主题
		public static var theme : IGTheme = new GASTheme;
		// 置顶数组
		public static var tops : Vector.<DisplayObject>=new Vector.<DisplayObject>();
		private static var _defaultCSS : StyleSheet;
		private static var _stage : Stage;
		private static var _url : String;

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
			_url = _stage.loaderInfo.url;
			if (_url.indexOf("/[[DYNAMIC]]/") != -1) {
				_url = _url.split("/[[DYNAMIC]]/")[0];
			}
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

		public static function get url() : String {
			return _url;
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

		/**
		 * 获得描边滤镜
		 * 
		 * @param edgeColor 描边颜色
		 * @param edgeAlpha 描边透明度 @default 1
		 */
		public static function getEdgeFilters(edgeColor : uint) : Array {
			return [new GlowFilter(edgeColor, 1, 2, 2, 1.5, 1, false, false)];
		}

		public static function getOffset(value : DisplayObject) : Point {
			var rect : Rectangle = GMathUtil.toIntRect(value.getBounds(value));
			return rect.topLeft;
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
			textField.height = textField.textHeight;
			return textField;
		}

		public static function atParent(source : DisplayObject, target : DisplayObject) : Boolean {
			if (source == null || target == null) {
				return false;
			}
			if (source == target) {
				return true;
			}
			var parent : DisplayObjectContainer = source.parent;
			while (parent != null) {
				if (parent == target) {
					return true;
				}
				parent = parent.parent;
			}
			return false;
		}

		public static function replace(source : DisplayObject, target : DisplayObject) : DisplayObject {
			if (source == null || source.parent == null || target == null || source == target) {
				return source;
			}
			var index : int = source.parent.getChildIndex(source);
			var parent : DisplayObjectContainer = source.parent;
			source.parent.removeChild(source);
			parent.addChildAt(target, index);
			return target;
		}

		public static function hitTest(x : int, y : int) : DisplayObject {
			if (_stage== null) {
				return null;
			}
			var result : Array = _stage.getObjectsUnderPoint(new Point(x, y));
			if (result == null) {
				return null;
			}
			return result.pop();
		}

		public static function setFullScreen(value : Boolean) : void {
			if (_stage!= null) {
				if (value == (_stage.displayState == StageDisplayState.FULL_SCREEN)) {
					return;
				}
				try {
					if (value) {
						_stage.displayState = StageDisplayState.FULL_SCREEN;
					} else {
						_stage.displayState = StageDisplayState.NORMAL;
					}
				} catch(e : SecurityError) {
					GLogger.debug(e.getStackTrace());
				}
			}
		}

		public static function cloneSkin(value : Object) : DisplayObject {
			if (value == null || !value is DisplayObject) {
				return null;
			}
			var className : String = getQualifiedClassName(value);
			if (className == "flash.display::Sprite") {
				var result : Sprite = new Sprite();
				result.graphics.copyFrom(Sprite(value).graphics);
				result.scale9Grid = Sprite(value).scale9Grid;
				result.mouseEnabled = result.mouseChildren = false;
				return result;
			}
			if (className == "flash.display::MovieClip") {
				return null;
			}
			var clone : DisplayObject = new value.constructor();
			if (clone is DisplayObjectContainer) {
				var doc : DisplayObjectContainer = DisplayObjectContainer(clone);
				doc.mouseEnabled = doc.mouseChildren = false;
			}
			return clone;
		}

		public static function calcTotal(target : DisplayObjectContainer, max : int = 1000000) : int {
			if (target == null) {
				return 0;
			}
			var list : Array = [target];
			var i : int;
			var j : int;
			var total : int = 0;
			var child : DisplayObject;
			while (list.length > 0 && total < max) {
				for (i = 0; i < list.length; i++) {
					target = list.shift() as DisplayObjectContainer;
					total++;
					if (target == null) {
						continue;
					}
					var len : int = target.numChildren;
					for (j = 0; j < len; j++) {
						child = target.getChildAt(j);
						if (child == null) {
							continue;
						}
						total++;
						list.push(child);
					}
				}
			}
			return total;
		}
	}
}