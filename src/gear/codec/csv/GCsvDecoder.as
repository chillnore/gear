package gear.codec.csv {
	/**
	 * csv文件解码
	 * 
	 * @author bright
	 * @version 20130305
	 */
	public class GCsvDecoder {
		private var _data : Vector.<Vector.<String>>;

		public function GCsvDecoder() {
		}

		public function decode(value : String) : void {
			var lines : Array = value.split(String.fromCharCode(13));
			_data = new Vector.<Vector.<String>>();
			for each (var line : String in lines) {
				_data.push(Vector.<String>(line.split(",")));
			}
		}
		
		public function get data():Vector.<Vector.<String>>{
			return _data;
		}
	}
}
