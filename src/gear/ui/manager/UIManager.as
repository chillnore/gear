package gear.ui.manager {
	import gear.log4a.GLogger;
	import gear.net.GLoadUtil;
	import gear.ui.bd.ScaleBitmapSprite;
	import gear.ui.skin.ASSkin;
	import gear.ui.skin.Skin;
	import gear.utils.MathUtil;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;

	/**
	 * UI管理器
	 * 
	 * @author bright
	 * @version 20120809
	 */
	public class UIManager {
		public static const SHADOW : DropShadowFilter = new DropShadowFilter(1, 45, 0, 0.5, 1, 1);
		public static var appWidth : int = 0;
		public static var appHeight : int = 0;
		public static var defaultFont : String = "Tahoma";
		public static var defaultSize : int = 12;
		private static var _defaultCSS : StyleSheet;
		private static var _root : Sprite;
		private static var _url : String;
		private static var _dragModal : Sprite = ASSkin.emptySkin;

		/**
		 * 设置根
		 * 
		 * @param value 根
		 */
		public static function set root(value : Sprite) : void {
			_root = value;
			_url = UIManager._root.loaderInfo.url;
			if (_url.indexOf("/[[DYNAMIC]]/") != -1) {
				_url = _url.split("/[[DYNAMIC]]/")[0];
			}
			var os : String = Capabilities.os;
			if (os.indexOf("Windows") != -1) {
				defaultFont = "Tahoma";
			} else if (os.indexOf("Mac") != -1) {
				defaultFont = "Monaco";
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
			return UIManager._root;
		}

		public static function get stageWidth() : int {
			return appWidth > 0 ? appWidth : _root.stage.stageWidth;
		}

		public static function get stageHeight() : int {
			return appHeight > 0 ? appHeight : _root.stage.stageHeight;
		}

		public static function get url() : String {
			return UIManager._url;
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
			var rect : Rectangle = MathUtil.toIntRect(value.getBounds(value));
			return rect.topLeft;
		}

		public static function getSkinBy(key : String, lib : String) : DisplayObject {
			var skin : DisplayObject;
			if (lib == ASSkin.AS_LIB) {
				skin = ASSkin.getThemeBy(key, lib);
			} else {
				skin = GLoadUtil.getSkin(key, lib);
				if (skin == null) {
					skin = ASSkin.getThemeBy(key, ASSkin.AS_LIB);
				} else if (skin is Sprite) {
					Sprite(skin).mouseEnabled = Sprite(skin).mouseChildren = false;
				}
			}
			return skin;
		}

		public static function createRect(color : uint, alpha : Number = 1) : Sprite {
			var skin : Sprite = new Sprite();
			skin.mouseEnabled = skin.mouseChildren = false;
			var g : Graphics = skin.graphics;
			g.beginFill(0, 1);
			g.drawRect(0, 0, 20, 20);
			g.endFill();
			g.beginFill(color, alpha);
			g.drawRect(1, 1, 18, 18);
			g.endFill();
			skin.scale9Grid = new Rectangle(1, 1, 18, 18);
			return skin;
		}

		public static function createBorder(color : uint = 0x000000) : Sprite {
			var skin : Sprite = new Sprite();
			skin.mouseEnabled = skin.mouseChildren = false;
			var g : Graphics = skin.graphics;
			g.beginFill(0, 0.2);
			g.drawRect(1, 1, 18, 18);
			g.endFill();
			g.beginFill(color, 1);
			g.drawRect(0, 0, 20, 1);
			g.endFill();
			g.beginFill(color, 1);
			g.drawRect(0, 1, 1, 18);
			g.endFill();
			g.beginFill(color, 1);
			g.drawRect(19, 1, 1, 18);
			g.endFill();
			g.beginFill(color, 1);
			g.drawRect(0, 19, 20, 1);
			g.endFill();
			skin.scale9Grid = new Rectangle(1, 1, 18, 18);
			return skin;
		}

		public static function createBar(color : uint = 0xFFFF00) : Sprite {
			var skin : Sprite = new Sprite();
			skin.mouseEnabled = skin.mouseChildren = false;
			var g : Graphics = skin.graphics;
			g.beginFill(0x000000, 1);
			g.drawRect(0, 0, 20, 20);
			g.endFill();
			g.beginFill(color, 1);
			g.drawRect(1, 1, 18, 18);
			g.endFill();
			g.beginFill(0xFFFFFF, 0.2);
			g.drawRect(1, 1, 18, 1);
			g.endFill();
			g.beginFill(0xFFFFFF, 0.2);
			g.drawRect(1, 1, 1, 18);
			g.endFill();
			g.beginFill(0xFFFFFF, 0.2);
			g.drawRect(18, 1, 1, 18);
			g.endFill();
			g.beginFill(0x000000, 0.2);
			g.drawRect(1, 18, 18, 1);
			g.endFill();
			skin.scale9Grid = new Rectangle(2, 2, 16, 16);
			return skin;
		}

		public static function getMask() : Sprite {
			var mask : Sprite = new Sprite();
			mask.mouseEnabled = false;
			var g : Graphics = mask.graphics;
			g.beginFill(0x0000FF, 1);
			g.drawRect(0, 0, 10, 10);
			g.endFill();
			return mask;
		}

		public static function getTextFormat() : TextFormat {
			var textFormat : TextFormat = new TextFormat();
			textFormat.font = defaultFont;
			textFormat.size = defaultSize;
			return textFormat;
		}

		public static function getTextField() : TextField {
			var textField : TextField = new TextField();
			textField.width = 0;
			textField.text = "?";
			textField.height = textField.textHeight + 4;
			textField.text = "";
			return textField;
		}

		public static function getInputTextField() : TextField {
			var textField : TextField = new TextField();
			textField.defaultTextFormat = UIManager.getTextFormat();
			textField.text = "?";
			textField.height = textField.textHeight + 4;
			textField.text = "";
			textField.tabEnabled = true;
			textField.type = TextFieldType.INPUT;
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
			var index : int = result.indexOf(_dragModal);
			if (index != -1) {
				result.splice(index, 1);
			}
			return result.pop();
		}

		public static function set dragModal(value : Boolean) : void {
			if (value) {
				if (_dragModal.parent == null) {
					_dragModal.width = _root.stage.stageWidth;
					_dragModal.height = _root.stage.stageHeight;
					_dragModal.mouseEnabled = _dragModal.mouseChildren = true;
					_root.addChild(_dragModal);
				}
			} else {
				if (_dragModal.parent != null) {
					_dragModal.parent.removeChild(_dragModal);
				}
			}
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
			if (value is Skin) {
				return Skin(value).clone();
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
			if (value is ScaleBitmapSprite == false) {
				var clone : DisplayObject = new value.constructor();
				if (clone is DisplayObjectContainer) {
					var doc : DisplayObjectContainer = DisplayObjectContainer(clone);
					doc.mouseEnabled = doc.mouseChildren = false;
				}
			} else {
				return value as DisplayObject;
			}
			return clone;
		}

		public static function calcAll(target : DisplayObjectContainer, max : int = 1000000) : int {
			if (target == null) {
				return 0;
			}
			var list : Array = [target];
			var i : int;
			var j : int;
			var k : int;
			var l : int;
			var total : int = 0;
			var child : DisplayObject;
			var mc : MovieClip;
			while (list.length > 0 && total < max) {
				for (i = 0; i < list.length; i++) {
					target = list.shift() as DisplayObjectContainer;
					if (target == null) {
						continue;
					}
					mc = target as MovieClip;
					if (mc != null) {
						for (j = 0; j < mc.totalFrames; j++) {
							mc.gotoAndStop(j);
							l = mc.numChildren;
							for (k = 0; k < l; k++) {
								child = target.getChildAt(k);
								total++;
								if (child == null) {
									continue;
								}
								list.push(child);
							}
						}
					} else {
						l = target.numChildren;
						for (j = 0; j < l; j++) {
							child = target.getChildAt(j);
							total++;
							if (child == null) {
								continue;
							}
							list.push(child);
						}
					}
				}
			}
			return total;
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

		public static function stopAll(target : DisplayObjectContainer, max : int = 1000000) : void {
			if (target == null) {
				return;
			}
			var list : Array = [target];
			var i : int;
			var j : int;
			var mc : MovieClip;
			var count : int = 0;
			var start : int = getTimer();
			while (list.length > 0 && count < max) {
				for (i = 0; i < list.length; i++) {
					target = list.shift();
					mc = target as MovieClip;
					if (mc != null && mc.totalFrames > 1) {
						mc.stop();
					}
					var len : int = target.numChildren;
					for (j = 0; j < len; j++) {
						mc = target.getChildAt(j) as MovieClip;
						if (mc != null && mc.totalFrames > 1) {
							mc.stop();
							list.push(mc);
						}
					}
				}
				count++;
			}
			GLogger.debug("count=" + count + ",time=" + (getTimer() - start) / 1000 + "s");
		}
	}
}