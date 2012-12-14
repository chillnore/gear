package gear.gui.utils {
	import gear.gui.skin.theme.GASTheme;
	import gear.gui.skin.theme.IGTheme;
	import gear.log4a.GLogger;
	import gear.utils.GMathUtil;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
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
	 * @version 20121129
	 */
	public final class GUIUtil {
		public static const SHADOW : DropShadowFilter = new DropShadowFilter(1, 45, 0, 0.5, 1, 1);
		public static var defaultFont : String = "Tahoma";
		public static var defaultSize : int = 12;
		public static var theme:IGTheme=new GASTheme;
		private static var _defaultCSS : StyleSheet;
		private static var _root : Sprite;
		private static var _url : String;

		/**
		 * 设置根
		 * 
		 * @param value 根
		 */
		public static function set root(value : Sprite) : void {
			_root = value;
			_url = GUIUtil._root.loaderInfo.url;
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

		/**
		 * 获得根
		 * 
		 * @return 根
		 */
		public static function get root() : Sprite {
			return GUIUtil._root;
		}

		public static function get url() : String {
			return GUIUtil._url;
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
		public static function getEdgeFilters(edgeColor : uint, edgeAlpha : Number = 1) : Array {
			return [new GlowFilter(edgeColor, edgeAlpha, 2, 2, 17, 1, false, false)];
		}

		public static function getOffset(value : DisplayObject) : Point {
			var rect : Rectangle = GMathUtil.toIntRect(value.getBounds(value));
			return rect.topLeft;
		}

		public static function getTextFormat() : TextFormat {
			var textFormat : TextFormat = new TextFormat();
			textFormat.font = defaultFont;
			textFormat.size = defaultSize;
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
			if (_root == null) {
				return null;
			}
			var result : Array = _root.getObjectsUnderPoint(new Point(x, y));
			if (result == null) {
				return null;
			}
			return result.pop();
		}

		public static function setFullScreen(value : Boolean) : void {
			if (_root != null) {
				if (value == (_root.stage.displayState == StageDisplayState.FULL_SCREEN)) {
					return;
				}
				try {
					if (value) {
						_root.stage.displayState = StageDisplayState.FULL_SCREEN;
					} else {
						_root.stage.displayState = StageDisplayState.NORMAL;
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