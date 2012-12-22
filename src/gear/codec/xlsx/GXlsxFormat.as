package gear.codec.xlsx {
	import gear.log4a.GLogError;
	import gear.log4a.GLogger;

	import mx.utils.StringUtil;

	/**
	 * Excel 表数据
	 * 
	 * @author bright
	 * @version 20121212
	 */
	public final class GXlsxFormat {
		private var _data : Array;
		private var _types : Array;
		private var _keys : Array;
		private var _names : Array;
		private var _rows : int;
		private var _columns : int;
		private var _output : Array;

		private function init() : void {
			if (_data == null) {
				return;
			}
			_data.shift();
			_types = _data.shift();
			_keys = _data.shift();
			_names = _data.shift();
			_rows = _data.length;
			_columns = _types.length;
			_output = new Array();
			var item : Object;
			var total : int;
			for (var row : int = 0;row < _rows;row++) {
				item = new Object();
				for (var column : int = 0;column < _columns;column++) {
					addTo(item, row, column);
				}
				total = 0;
				for each (var sub:* in item) {
					sub;
					total++;
				}
				if (total > 0) {
					_output.push(item);
				}
			}
		}

		private function addTo(item : Object, row : int, column : int) : void {
			var type : String = _types[column];
			if (type == null) {
				return;
			}
			var key : String = _keys[column];
			if (key == null) {
				return;
			}
			var value : * = _data[row][column];
			if (value == null) {
				return;
			}
			switch(type) {
				case "String":
					item[key] = StringUtil.trim(String(value));
					break;
				case "uint":
					item[key] = uint(value);
					break;
				case "int":
					item[key] = int(value);
					break;
				case "Number":
					item[key] = Number(value);
					break;
				case "Array.<uint>":
					item[key] = toArrayUint(value);
					break;
				case "Array.<int>":
					item[key] = toArrayInt(value);
					break;
				case "Array.<String>":
					item[key] = toArrayString(value);
					break;
				case "Array.<Array.<int>>":
					item[key] = toArrayArrayInt(value);
					break;
				case "Array.<Rectangle>":
					item[key] = toArrayRectObj(value);
					break;
				case "Array.<Point>":
					item[key] = toArrayPointObj(value);
					break;
				case "Array.<PlayData>":
					item[key] = toArrayPlayData(value);
					break;
				case "Rectangle":
					item[key] = toRectObj(value);
					break;
				case "Boolean":
					item[key] = (value == "是" ? true : false);
					break;
				case "json":
					item[key] = JSON.parse(value);
					break;
				default:
					throw new GLogError("第" + column + "列类型错误:" + type + "," + key);
					break;
			}
		}

		private function toArrayUint(value : String) : Array {
			var source : Array = value.split(",");
			if (source.length < 1) {
				return null;
			}
			var total : int = source.length;
			var target : Array = new Array();
			for (var i : int = 0;i < total;i++) {
				target[i] = uint(source[i]);
			}
			return target;
		}

		private function toArrayInt(value : String) : Array {
			var source : Array = value.split(",");
			if (source.length < 1) {
				return null;
			}
			var total : int = source.length;
			var target : Array = new Array();
			for (var i : int = 0;i < total;i++) {
				target[i] = int(source[i]);
			}
			return target;
		}

		private function toArrayPlayData(value : String) : Array {
			var params : Array = value.split("_");
			var target : Array = new Array();
			var object : Object;
			var data : Array;
			for (var i : int = 0;i < params.length;i++) {
				object = new Object();
				data = toArrayInt(params[i]);
				object.delay = data.shift();
				object.frames = data;
				target.push(object);
			}
			return target;
		}

		private function toArrayString(value : String) : Array {
			var source : Array = value.split(",");
			if (source.length < 1) {
				return null;
			}
			var total : int = source.length;
			var target : Array = new Array();
			for (var i : int = 0;i < total;i++) {
				target[i] = String(source[i]);
			}
			return target;
		}

		private function toArrayArrayInt(value : String) : Array {
			var source : Array = value.split("_");
			if (source.length < 1) {
				return null;
			}
			var total : int = source.length;
			var target : Array = new Array();
			for (var i : int = 0;i < total;i++) {
				target[i] = String(source[i]).split(",");
			}
			return target;
		}

		private function toArrayRectObj(value : String) : Array {
			var params : Array = value.split("_");
			var target : Array = new Array();
			for (var i : int = 0;i < params.length;i++) {
				target.push(toRectObj(params[i]));
			}
			return target;
		}

		private function toRectObj(value : String) : Object {
			var params : Array = value.split(",");
			if (params.length < 4) {
				return null;
			}
			return {x:int(params[0]), y:int(params[1]), width:int(params[2]), height:int(params[3])};
		}

		private function toArrayPointObj(value : String) : Array {
			var params : Array = value.split("_");
			var target : Array = new Array();
			for (var i : int = 0;i < params.length;i++) {
				target.push(toPointObj(params[i]));
			}
			return target;
		}

		private function toPointObj(value : String) : Object {
			var params : Array = value.split(",");
			if (params.length < 2) {
				return null;
			}
			return {x:int(params[0]), y:int(params[1])};
		}

		public function GXlsxFormat(data : Array) {
			if (data.length < 4) {
				GLogger.error("");
				return;
			}
			_data = data.concat();
			init();
		}

		public function get rows() : int {
			return _rows;
		}

		public function get columns() : int {
			return _columns;
		}

		public function get output() : Array {
			return _output;
		}
	}
}
