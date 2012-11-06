package gear.data {
	import gear.utils.GMathUtil;

	import flash.utils.Dictionary;

	/**
	 * 哈希表
	 * 
	 * @author bright
	 * @version 20121025
	 */
	public class HashMap {
		private var _keys : Array ;
		private var _values : Dictionary;

		public function HashMap() {
			_keys = new Array();
			_values = new Dictionary(true);
		}

		/**
		 * 是否包含键
		 * 
		 * @param key 键
		 * @return 是否有键
		 */
		public function containsKey(key : *) : Boolean {
			return _values.hasOwnProperty(key);
			return _keys.indexOf(key) != -1;
		}

		/**
		 * 是否包含值
		 * 
		 * @param value 值
		 * @return 是否有值
		 */
		public function containsValue(value : *) : Boolean {
			for each (var key:* in _keys) {
				if (_values[key] == value)
					return true;
			}
			return false;
		}

		/**
		 * 放入键-值
		 * 
		 * @param key 键
		 * @param value 值
		 * @example 
		 * <listing version="3.0">
		 * var hashMap:HashMap=new HashMap();
		 * hashMap.put("key","value");
		 * </listing>
		 */
		public function put(key : *, value : *) : void {
			if (_values[key] != null) {
				_values[key] = value;
			} else {
				_values[key] = value;
				_keys.push(key);
			}
		}

		/**
		 * 根据键
		 * 
		 * @param key 键
		 * @return 键对值	     * @example 
		 * <listing version="3.0">
		 * var hashMap:HashMap=new HashMap();
		 * hashMap.put("key","value");
		 * var result:String=hashMap.getBy("key");
		 * </listing>
		 */
		public function getBy(key : *) : * {
			if (key == null) {
				return null;
			}
			return _values[key];
		}

		/**
		 * 根据索引对应的值
		 * @param index 索引
		 * @return 索引对应的值
		 * @example 
		 * <listing version="3.0">
		 * var hashMap:HashMap=new HashMap();
		 * hashMap.put("key","value");
		 * var result:String=hashMap.getAt(0);
		 * </listing>
		 */
		public function getAt(index : int) : * {
			return _values[_keys[index]];
		}

		/**
		 * 删除键
		 * 
		 * @param key 键
		 * @return 键对应索引
		 * @example
		 * <listing version="3.0">
		 * var hashMap:HashMap=new HashMap();
		 * hashMap.put("key","value");
		 * var index:int=hashMap.removeBy("key");
		 * </listing>
		 */
		public function removeBy(key : *) : int {
			if (_values[key] != null) {
				delete _values[key];
				var index : int = this._keys.indexOf(key);
				if (index == -1)
					return -1;
				_keys.splice(index, 1);
				return index;
			}
			return -1;
		}

		/**
		 * 清除所有的键值
		 */
		public function clear() : void {
			for each (var key:* in _keys) {
				delete _values[key];
			}
			_keys.length = 0;
		}

		/**
		 * 是否为空
		 * 
		 * @return 是否为空
		 * @example 
		 * <listing version="3.0">
		 * var hashMap:HashMap=new HashMap();
		 * hashMap.put("key","value");
		 * trace(hashMap.isEmpty) // 输出 flase
		 * </listing>
		 */
		public function isEmpty() : Boolean {
			return _keys.length < 1;
		}

		/**
		 * 获得哈希表大小
		 * 
		 * @return 哈希表大小
		 * @example 
		 * <listing version="3.0">
		 * var hashMap:HashMap=new HashMap();
		 * hashMap.put("key","value");
		 * trace(hashMap.size); // 输出1
		 * </listing>
		 */
		public function get size() : uint {
			return _keys.length;
		}

		/**
		 * 获得键组
		 * 
		 * @return 键组
		 * @example
		 * <listing version="3.0">
		 * var hashMap:HashMap=new HashMap();
		 * hashMap.put("key","value");
		 * trace(hashMap.keys); // 输出["key"]
		 * </listing>
		 */
		public function get keys() : Array {
			return _keys;
		}

		/**
		 * 获得键值字典
		 * 
		 * @return 转换后的字典
		 * @example
		 * <listing version="3.0">
		 * var hashMap:HashMap=new HashMap();
		 * hashMap.put("key","value");
		 * Logger.debug(hashMap.values); // 输出[debug]{"key","value"}
		 * </listing>
		 */
		public function get values() : Dictionary {
			return _values;
		}

		/**
		 * 获得随机值
		 * 
		 * @return 随机值
		 * @example
		 * <listing version="3.0">
		 * var hashMap:HashMap=new HashMap();
		 * hashMap.put("key1","value1");
		 * hashMap.put("key2","value2");
		 * trace(hashMap.randomValue) // 输出"value1"或"value2"
		 * </listing>
		 */
		public function get randomValue() : * {
			return _values[_keys[GMathUtil.random(0, _keys.length - 1)]];
		}

		/**
		 * 转换成值数组
		 * 
		 * @return 转换后的值数组
		 * @example
		 * <listing version="3.0">
		 * var hashMap:HashMap=new HashMap();
		 * hashMap.put("key","value");
		 * trace(hashMap.toArray()) // 输出["value"]
		 * </listing>
		 */
		public function toArray() : Array {
			var list : Array = new Array();
			for each (var key:Object in _keys) {
				list.push(_values[key]);
			}
			return list;
		}

		/**
		 * 转换成字符串
		 * @return 字符串
		 * @example
		 * <listing version="3.0">
		 * var hashMap:HashMap=new HashMap();
		 * hashMap.put("key","value");
		 * trace(hashMap.toArray()) // 输出["value"]
		 * </listing>
		 */
		public function toString() : String {
			var out : String = "";
			for each (var key:* in _keys) {
				out += key + "=" + _values[key] + "\n";
			}
			return out;
		}
	}
} 