package gear.net {
	/**
	 * 文件工具类
	 * 
	 * @author bright
	 * @version 20121023
	 */
	public final class FileType {
		public static const BIN : int = -1;
		public static const SWF : int = 0;
		public static const PNG : int = 1;
		public static const JPG : int = 2;
		public static const MP3 : int = 3;
		public static const XML : int = 4;
		public static const XLSX : int = 5;
		public static const PLIST : int = 6;

		public static function getKey(url : String) : String {
			var separator : String = (url.indexOf("/") > -1) ? "/" : "\\";
			return url.split(separator).pop();
		}

		/**
		 * 根据url来获得文件类型
		 * 
		 * @param url URL地址
		 * @return int 文件类型常量
		 */
		public static function getType(url : String) : int {
			var separator : String = (url.indexOf("/") > -1) ? "/" : "\\";
			var files : Array = url.split(separator).pop().split(".");
			var typeName : String = files[1];
			var type : int = BIN;
			switch(typeName) {
				case "swf":
					type = SWF;
					break;
				case "png":
					type = PNG;
					break;
				case "jpg":
					type = JPG;
					break;
				case "mp3":
					type = MP3;
					break;
				case "xml":
					type = XML;
					break;
				case "xlsx":
					type = XLSX;
					break;
				case "plist":
					type = PLIST;
					break;
				default:
					break;
			}
			return type;
		}
	}
}
