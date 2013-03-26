package gear.log4a {
	import gear.utils.GStringUtil;
	/**
	 * 日志错误类
	 * 
	 * @author bright
	 * @version 20101012
	 * @example
	 * throw new LogError("System Error");
	 */
	public class GLogError extends Error {
		
		protected function format(target:Array):String{
			if (target == null || target.length < 1) {
				return "null";
			}
			if (target[0] is String && GStringUtil.hasFormat(target[0])) {
				return GStringUtil.format.apply(null,target);
			}
			var result : String = "";
			for each (var item:* in target) {
				if (result.length > 0) {
					result += " ";
				}
				result += GStringUtil.toString(item);
			}
			return result;
		}
		public function GLogError(...log : Array) {
			var message:String=format(log);
			super(message);
			GLogger.error(message);
		}
	}
}