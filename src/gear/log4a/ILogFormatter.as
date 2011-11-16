package gear.log4a {
	/**
	 * 日志格式化接口
	 * 
	 * @author bright
	 * @version 20101009
	 */
	public interface ILogFormatter {
		/**
		 * 格式化输出
		 * 
		 * @param data 日志数据
		 * @param separator 行分隔符 @default "\n"
		 */
		function format(data : LoggingData, separator : String = "\n"):String;
	}
}