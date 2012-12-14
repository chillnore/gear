package gear.utils {
	import flash.utils.Dictionary;

	/**
	 * 字典工具类
	 * 
	 * @author bright
	 * @version 20121112
	 */
	public final class GDictUtil {
		public static function isEmpty(dict : Dictionary) : Boolean {
			var item : Object;
			for each (item in dict) {
				return false;
			}
			item;
			return true;
		}

		public static function getKeys(dict : Dictionary) : Array {
			var keys : Array = new Array();
			for (var key:Object in dict) {
				keys.push(key);
			}
			return keys;
		}

		public static function getValues(dict : Dictionary) : Array {
			var values : Array = new Array();
			for each (var value:Object in dict) {
				values.push(value);
			}
			return values;
		}

		public static function clear(dict : Dictionary) : void {
			for (var key:Object in dict) {
				delete dict[key];
			}
		}
	}
}