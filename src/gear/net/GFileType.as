﻿package gear.net {
	/**
	 * 文件类型
	 * 
	 * @author bright
	 * @version 20130509
	 */
	public final class GFileType {
		public static const BIN : int = -1;
		public static const GPK : int = 0;
		public static const SWF : int = 1;
		public static const PNG : int = 2;
		public static const JPG : int = 3;
		public static const GIF : int = 4;
		public static const MP3 : int = 5;
		public static const XML : int = 6;
		public static const JSON : int = 7;
		public static const XLSX : int = 8;
		public static const CSV : int = 9;
		public static const PSD : int = 10;
		public static const PLIST : int = 11;
		public static const ATF : int = 12;
		private static const _types : Vector.<String>=new <String>["gpk", "swf", "png", "jpg", "gif", "mp3", "xml", "json", "xlsx", "csv", "psd", "plist", "atf"];

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
			return _types.indexOf(typeName);
		}
	}
}