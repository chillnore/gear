package gear.pool {
	import gear.core.IDispose;
	import gear.log4a.GLogError;

	/**
	 * 对象池
	 * 
	 * @example
	 * <listing version="3.0"> 
	 * GObjPool对象池使用示例:
	 * 
	 * var pool:GObjPool=new GObjPool(Point);
	 * var point:Point=pool.borrowObj(100,100);
	 * trace(point.x,point.y);
	 * pool.returnObj(point);
	 * </listing>
	 * @author bright
	 * @version 20130415
	 */
	public final class GObjPool implements IDispose {
		private var _class : Class;
		private var _idles : Vector.<Object>;
		
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
					throw new GLogError("对象池构造参数数量不能超过10个!");
			}
		}

		public function GObjPool(value : Class) {
			_class = value;
			_idles = new Vector.<Object>();
		}

		public function borrowObj(...args : Array) : Object {
			if (_idles.length > 0) {
				var temp : Object = _idles.shift();
				return temp;
			}
			return construct(args);
		}

		public function returnObj(value : Object) : void {
			_idles.push(value);
		}

		public function dispose() : void {
			_idles.length = 0;
		}
	}
}
