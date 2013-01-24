package gear.socket {
	import gear.log4a.GLogger;

	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.ObjectEncoding;
	import flash.net.Socket;
	import flash.system.Security;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * Socket客户端
	 * 
	 * @author bright
	 * @version 20111207
	 */
	public final class SocketClient extends EventDispatcher {
		public static const IO_ERROR : String = "ioError";
		public static const SECURITY_ERROR : String = "securityError";
		public static const CLOSE : String = "close";
		private var _callPool : GCallPool;
		private var _buffer : ByteArray;
		private var _socket : Socket;
		private var _data : SocketData;
		private var _length : int;
		private var _writeBytes : uint = 0;
		private var _readBytes : uint = 0;
		private var _test : Dictionary;

		private function init() : void {
			reset();
			_socket = new Socket();
			_socket.objectEncoding = ObjectEncoding.AMF3;
			_data = new SocketData("default", "127.0.0.1", 1863);
			_callPool = new GCallPool();
			_test = new Dictionary();
			addSocketEvents();
		}

		private function reset() : void {
			_buffer = new ByteArray();
			_length = 0;
		}

		private function addSocketEvents() : void {
			_socket.addEventListener(IOErrorEvent.IO_ERROR, socket_ioErrorHandler);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, socket_securityErrorHandler);
			_socket.addEventListener(Event.CONNECT, socket_connectHandler);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, socket_dataHandler);
			_socket.addEventListener(Event.CLOSE, socket_closeHandler);
		}

		private function socket_ioErrorHandler(event : IOErrorEvent) : void {
			GLogger.debug("socket io error", _data.host, _data.port, _data.toString());
			_callPool.dispose();
			dispatchEvent(new Event(IO_ERROR));
		}

		private function socket_securityErrorHandler(event : SecurityErrorEvent) : void {
			GLogger.debug("socket security error", _data.host, _data.port, _data.toString());
			_callPool.dispose();
			dispatchEvent(new Event(SECURITY_ERROR));
		}

		private function socket_connectHandler(event : Event) : void {
			GLogger.debug("connect success!", _data.toString());
			dispatchEvent(new Event(Event.CONNECT));
		}

		private function socket_dataHandler(event : ProgressEvent) : void {
			while (_socket.bytesAvailable > 4) {
				if (_length == 0) {
					_length = _socket.readInt();
				}
				if (_socket.bytesAvailable < _length) {
					break;
				}
				try {
					_buffer = new ByteArray();
					_socket.readBytes(_buffer, 0, _length);
					var value : Object = _buffer.readObject();
					_callPool.addRequest(GCallData.parse(value));
					_readBytes += _length + 4;
				} catch(e : Error) {
					GLogger.error(_data.toString(), _length, e.getStackTrace());
				}
				_length = 0;
			}
		}

		private function socket_closeHandler(event : Event) : void {
			GLogger.debug("socket close", _data.toString(), "messageSize:", _callPool.size);
			_callPool.dispose();
			dispatchEvent(new Event(CLOSE));
		}

		public function SocketClient() {
			init();
		}

		public function setDealStrategy(queue : Boolean) : void {
			_callPool.queue = queue;
		}

		public function get data() : SocketData {
			return _data;
		}

		/**
		 * @param value 测试调用
		 */
		public function setTest(value : SocketCall) : void {
			_test[value.method] = value;
		}

		/**
		 * addCallback
		 * 
		 * @param method String 回调方法名
		 * @param callback Function 回调函数
		 */
		public function addCallback(method : String, callback : Function) : void {
			_callPool.addCallback(method, callback);
		}

		/**
		 * removeCallback
		 * 
		 * @param method String 回调方法名
		 * @param callback Function 回调函数
		 */
		public function removeCallback(method : String, callback : Function) : void {
			_callPool.removeCallback(method, callback);
		}

		/**
		 * connected
		 * 
		 * @return Boolean 
		 */
		public function connected(data : SocketData) : Boolean {
			return _data.equals(data) && _socket.connected;
		}

		public function connect(data : SocketData) : void {
			if (connected(data)) {
				return;
			}
			if (_socket.connected) {
				_callPool.dispose();
				_socket.close();
				reset();
			}
			_data = data;
			try {
				Security.loadPolicyFile("xmlsocket://" + _data.host + ":" + _data.port);
				_socket.connect(_data.host, _data.port);
			} catch(e : Error) {
				GLogger.error(e.getStackTrace());
			}
		}

		public function disconnect() : void {
			if (_socket.connected) {
				try {
					_callPool.dispose();
					reset();
					_socket.close();
				} catch(e : IOError) {
					GLogger.error(e.getStackTrace());
				}
			}
		}

		public function get isActive() : Boolean {
			return _socket.connected;
		}

		/**
		 * call 远程调用
		 * 
		 * @param method 方法名
		 * @param args 参数数组
		 */
		public function call(method : String, ...args : Array) : void {
			if (_test[method] != null) {
				args.unshift(_test[method].call);
				_test[method].invoke.apply(null, args);
				return;
			}
			if (!_socket.connected) {
				return;
			}
			var ba : ByteArray = new ByteArray();
			var call : Object = {method:method, args:args};
			ba.writeObject(call);
			_socket.writeUnsignedInt(ba.length);
			_socket.writeBytes(ba, 0, ba.length);
			_socket.flush();
			_writeBytes += ba.length + 4;
		}

		public function get writeBytes() : uint {
			return _writeBytes;
		}

		public function get readBytes() : uint {
			return _readBytes;
		}
	}
}