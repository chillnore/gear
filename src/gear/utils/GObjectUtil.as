package gear.utils {
	/**
	 * 对象工具类
	 * 
	 * @author bright
	 * @version 20130124
	 */
	public final class GObjectUtil {
		public static function append(source : Object, target : Object) : void {
			for (var i:String in target) {
				source[i] = target[i];
			}
		}
	}
}
