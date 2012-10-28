package gear.pool {
	import gear.core.IDispose;
	import gear.log4a.LogError;

	/**
	 * 对象池
	 * 
	 * @author bright
	 * @version 20121025
	 */
	public class ObjPool implements IDispose {
		protected var _class : Class;
		protected var _list : Array;

		protected function construct(args : Array) : Object {
			switch( args.length ) {
				case 0:
					return new _class();
				case 1:
					return new _class(args[0]);
				case 2:
					return new _class(args[0], args[1]);
				case 3:
					return new _class(args[0], args[1], args[2]);
				case 4:
					return new _class(args[0], args[1], args[2], args[3]);
				case 5:
					return new _class(args[0], args[1], args[2], args[3], args[4]);
				case 6:
					return new _class(args[0], args[1], args[2], args[3], args[4], args[5]);
				case 7:
					return new _class(args[0], args[1], args[2], args[3], args[4], args[5], args[6]);
				case 8:
					return new _class(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]);
				case 9:
					return new _class(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8]);
				case 10:
					return new _class(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9]);
				default:
					throw new LogError("ObjectPool.construct args length >10!");
			}
		}

		public function ObjPool(value : Class, total : int = 0) {
			_class = value;
			_list = new Array();
			for (var i : int = 0;i < total;i++) {
				_list.push(borrowObj());
			}
		}

		public function borrowObj(...args : Array) : Object {
			if (_list.length > 0) {
				var temp : Object = _list.shift();
				return temp;
			}
			return construct(args);
		}

		public function returnObj(value : Object) : void {
			_list.push(value);
		}

		public function dispose() : void {
			_list.length = 0;
			_list = null;
		}
	}
}
