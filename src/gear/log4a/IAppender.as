package gear.log4a {
	/**
	 * 日志输出源接口
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public interface IAppender {
		/**
		 * 追加日志数据
		 * 
		 * @param data 日志数据
		 */
		function append(data : GLoggingData):void;
	}
}