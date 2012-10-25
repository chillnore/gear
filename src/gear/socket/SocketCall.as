package gear.socket {
	/**
	 * @author flashpf
	 */
	public final class SocketCall {
		private var _method : String;
		private var _invoke : Function;
		private var _call : Function;

		/**
		 * @param method 方法名
		 * @param invoke 响应函数
		 * @param call 回调函数
		 */
		public function SocketCall(method : String, invoke : Function, call : Function) {
			_method = method;
			_invoke = invoke;
			_call = call;
		}

		public function get method() : String {
			return _method;
		}

		public function get invoke() : Function {
			return _invoke;
		}

		public function get call() : Function {
			return _call;
		}
	}
}
