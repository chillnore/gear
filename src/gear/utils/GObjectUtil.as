package gear.utils {
	public class GObjectUtil {
		public static function append(source : Object, target : Object) : void {
			for (var i:String in target) {
				source[i] = target[i];
			}
		}
	}
}
