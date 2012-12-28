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
			if(_data[row]==null||_data[row][column]==null){
				return;
			}
			var value : * = _data[row][column];
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
				case "Vector.<int>":
					item[key] = toVectorInt(value);
					break;
				case "Vector.<uint>":
					item[key] = toVectorUint(value);
					break;
				case "Vector.<String>":
					item[key] = toVectorString(value);
					break;
				case "Vector.<Vector.<int>>":
					item[key] = toVectorVectorInt(value);
					break;
				case "Vector.<Rectangle>":
					item[key] = toVectorRectObj(value);
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

		private function toVectorInt(value : String) : Vector.<int> {
			var source : Array = value.split(",");
			if (source.length < 1) {
				return null;
			}
			var total : int = source.length;
			var target : Vector.<int> = new Vector.<int>(total, true);
			for (var i : int = 0;i < total;i++) {
				target[i] = int(source[i]);
			}
			return target;
		}

		private function toVectorUint(value : String) : Vector.<uint> {
			var source : Array = value.split(",");
			if (source.length < 1) {
				return null;
			}
			var total : int = source.length;
			var target : Vector.<uint> = new Vector.<uint>(total, true);
			for (var i : int = 0;i < total;i++) {
				target[i] = uint(source[i]);
			}
			return target;
		}

		private function toVectorString(value : String) : Vector.<String> {
			var source : Array = value.split(",");
			if (source.length < 1) {
				return null;
			}
			var total : int = source.length;
			var target : Vector.<String> = new Vector.<String>();
			for (var i : int = 0;i < total;i++) {
				target[i] = String(source[i]);
			}
			return target;
		}

		private function toVectorVectorInt(value : String) : Vector.<Vector.<int>> {
			var source : Array = value.split("_");
			if (source.length < 1) {
				return null;
			}
			var total : int = source.length;
			var target : Vector.<Vector.<int>>=new Vector.<Vector.<int>>();
			for (var i : int = 0;i < total;i++) {
				target[i] = toVectorInt(String(source[i]));
			}
			return target;
		}

		private function toVectorRectObj(value : String) : Vector.<Object> {
			var source : Array = value.split("_");
			if (source.length < 1) {
				return null;
			}
			var total : int = source.length;
			var target : Vector.<Object> = new Vector.<Object>(total, true);
			for (var i : int = 0;i < total;i++) {
				target[i] = toRectObj(source[i]);
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
