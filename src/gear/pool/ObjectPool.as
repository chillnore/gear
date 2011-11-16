package gear.pool {
	import gear.core.IDispose;
	import gear.log4a.LogError;

	/**
	 * 对象池
	 * 
	 * @author bright
	 * @version 20111014
	 */
	public class ObjectPool implements IDispose {
		protected var _type : Class;
		protected var _list : Array;

		protected function construct(args : Array) : Object {
			switch( args.length ) {
				case 0:
					return new _type();
				case 1:
					return new _type(args[0]);
				case 2:
					return new _type(args[0], args[1]);
				case 3:
					return new _type(args[0], args[1], args[2]);
				case 4:
					return new _type(args[0], args[1], args[2], args[3]);
				case 5:
					return new _type(args[0], args[1], args[2], args[3], args[4]);
				case 6:
					return new _type(args[0], args[1], args[2], args[3], args[4], args[5]);
				case 7:
					return new _type(args[0], args[1], args[2], args[3], args[4], args[5], args[6]);
				case 8:
					return new _type(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]);
				case 9:
					return new _type(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8]);
				case 10:
					return new _type(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9]);
				default:
					throw new LogError("ObjectPool.construct args length >10!");
			}
		}

		public function ObjectPool(type : Class) {
			_type = type;
			_list = new Array();
		}

		public function getObject(...args : Array) : Object {
			if (_list.length > 0) {
				return _list.shift();
			}
			return construct(args);
		}

		public function returnObject(value : Object) : void {
			_list.push(value);
		}

		public function dispose() : void {
			_list.splice(0);
			_list = null;
		}
	}
}
