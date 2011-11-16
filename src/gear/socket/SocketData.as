package gear.socket {
	/**
	 * Socket定义
	 * 
	 * @author bright
	 * @version 20100115
	 */
	public class SocketData {
		private var _name : String;
		private var _host : String;
		private var _port : int;
		private var _flag : int;

		/**
		 * 构造函数
		 * 
		 * @param name 名称
		 * @param host IP地址
		 * @param port 端口
		 * @param flag 标识
		 */
		public function SocketData(name : String, host : String, port : int, flag : int = 0) {
			_name = name;
			_host = host;
			_port = port;
			_flag = flag;
		}

		/**
		 * @return 名称
		 */
		public function get name() : String {
			return _name;
		}

		/**
		 * @return 地址
		 */
		public function get host() : String {
			return _host;
		}

		public function get port() : int {
			return _port;
		}

		public function get flag() : int {
			return _flag;
		}

		public function equals(data : SocketData) : Boolean {
			return _name == data.name && _host == data.host && _port == data.port;
		}

		public function toString() : String {
			return _name + ".socket://" + _host + ":" + _port;
		}
	}
}