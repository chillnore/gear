package gear.utils {
	import flash.display.DisplayObject;
	import flash.utils.getQualifiedClassName;

	public final class GNameUtil {
		private static var _counter : int = 0;

		/**
		 * 获得唯一的名字
		 */
		public static function createUniqueName(object : Object) : String {
			if (object == null) {
				return null;
			}
			var name : String = getQualifiedClassName(object);
			var index : int = name.indexOf("::");
			if (index != -1) {
				name = name.substr(index + 2);
			}
			var charCode : int = name.charCodeAt(name.length - 1);
			if (charCode >= 48 && charCode <= 57) {
				name += "_";
			}
			return name + _counter++;
		}

		/**
		 * 获得路径名字
		 */
		public static function getPathName(displayObject : DisplayObject) : String {
			var result : String="";
			try {
				for (var o : DisplayObject = displayObject;o != null;o = o.parent) {
					if (o.parent && o.stage && o.parent == o.stage) {
						break;
					}
					var s : String = "id" in o && o["id"] ? o["id"] : o.name;
					result = (result == null) ? s : s + "." + result;
				}
			} catch (e : SecurityError) {
			}
			return result;
		}
	}
}