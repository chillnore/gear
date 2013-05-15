package gear.net {
	import gear.codec.gpk.Gpk;
	import gear.codec.xlsx.GWorkSheet;
	import gear.gui.bd.GBDList;
	import gear.log4a.GLogError;
	import gear.log4a.GLogger;

	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * 加载管理器
	 * 
	 * @author bright
	 * @version 20121105
	 */
	public final class GLoadUtil {
		// 最大并发加载数
		public static const MAX : int = 5;
		// 加载组
		internal static var groups : Vector.<GLoadGroup>=new Vector.<GLoadGroup>();
		// 创建队列
		private static var _created : Dictionary = new Dictionary();
		// 加载完成队列
		private static var _loaded : Dictionary = new Dictionary();
		// 正在加载队列
		private static var _loadings : Vector.<AGLoader>=new Vector.<AGLoader>();
		// 等待加载队列
		private static var _waits : Vector.<AGLoader>=new Vector.<AGLoader>();

		internal static function loadNext(loader : AGLoader) : void {
			var index : int = _loadings.indexOf(loader);
			if (index != -1) {
				_loadings.splice(index, 1);
			}
			if (loader.state == GLoadState.COMPLETE) {
				_loaded[loader.key] = loader;
			}
			var group : GLoadGroup;
			var finishs : Vector.<GLoadGroup>=new Vector.<GLoadGroup>();
			for each (group in groups) {
				group.loadNext(loader);
				if (group.isFinish) {
					finishs.push(group);
				}
			}
			for each (group in finishs) {
				index = groups.indexOf(group);
				if (index != -1) {
					groups.splice(index, 1);
				}
			}
			if (_waits.length < 1) {
				return;
			}
			_waits.shift().load();
		}

		/**
		 * 构造函数
		 * 
		 * @throws LogError 不能被实例化
		 */
		public function GLoadUtil() {
			throw (new GLogError("静态类不能构造!"));
		}

		/**
		 * 创建加载器-工厂模式
		 * 
		 * @param url URL地址
		 * @return ALoader 抽象加载器
		 */
		internal static function create(url : String, key : String = null) : AGLoader {
			if (key == null) {
				key = GFileType.getKey(url);
			}
			var loader : AGLoader = _created[key];
			if (loader != null) {
				return loader;
			}
			var type : int = GFileType.getType(url);
			switch(type) {
				case GFileType.GPK:
					loader = new GpkLoader(url, key);
					break;
				case GFileType.SWF:
					loader = new GSwfLoader(url, key);
					break;
				case GFileType.PNG:
					loader = new GImgLoader(url, key);
					break;
				case GFileType.JPG:
					loader = new GImgLoader(url, key);
					break;
				case GFileType.GIF:
					loader = new GGifLoader(url, key);
					break;
				case GFileType.MP3:
					loader = new GMp3Loader(url, key);
					break;
				case GFileType.XML:
					loader = new GXmlLoader(url, key);
					break;
				case GFileType.JSON:
					loader = new GJsonLoader(url, key);
					break;
				case GFileType.XLSX:
					loader = new GXlsxLoader(url, key);
					break;
				case GFileType.CSV:
					loader = new GCsvLoader(url, key);
					break;
				case GFileType.PSD:
					loader = new GPsdLoader(url, key);
					break;
				case GFileType.PLIST:
					loader = new GPlistLoader(url, key);
					break;
				case GFileType.ATF:
					loader = new GAtfLoader(url, key);
					break;
				default:
					loader = new GBinLoader(url, key);
					break;
			}
			_created[key] = loader;
			return loader;
		}

		internal static function startLoad(loader : AGLoader) : void {
			if (loader.state != GLoadState.NONE) {
				return;
			}
			if (_loadings.length < MAX) {
				if (_loadings.indexOf(loader) == -1) {
					_loadings.push(loader);
					loader.load();
				}
			} else if (_waits.indexOf(loader) == -1) {
				_waits.push(loader);
				loader.wait();
			}
		}

		/**
		 * 加载
		 * 
		 * @param url 加载地址
		 * @param onLoaded 加载完成回调函数
		 * @param onFailed 加载失败回调函数
		 * @param reload 是否重新加载
		 */
		public static function load(url : String, onLoaded : Function, onFailed : Function = null, onProgress : Function = null, reload : Boolean = false) : IGLoader {
			var loader : AGLoader = create(url);
			if (reload) {
				loader.reload();
			}
			if (loader.state == GLoadState.NONE) {
				loader.onLoaded = onLoaded;
				loader.onFailed = onFailed;
				startLoad(loader);
			}
			return loader;
		}

		public static function getByteArray(key : String) : ByteArray {
			var loader : GBinLoader = _loaded[key] as GBinLoader;
			return loader != null ? loader.byteArray : null;
		}

		public static function getGpk(lib : String) : Gpk {
			var loader : GpkLoader = _loaded[lib] as GpkLoader;
			return loader != null ? loader.gpk : null;
		}

		public static function getGpkAMF(key : String, lib : String) : * {
			var loader : GpkLoader = _loaded[lib] as GpkLoader;
			if (loader == null) {
				return null;
			}
			var gpk : Gpk = loader.gpk;
			return gpk != null ? gpk.getAMF(key) : null;
		}

		public static function getGpkSBD(key : String, lib : String) : BitmapData {
			var loader : GpkLoader = _loaded[lib] as GpkLoader;
			if (loader == null) {
				return null;
			}
			var gpk : Gpk = loader.gpk;
			return gpk != null ? gpk.getSBD(key) : null;
		}

		public static function getGpkLBD(key : String, lib : String) : GBDList {
			var loader : GpkLoader = _loaded[lib] as GpkLoader;
			if (loader == null) {
				GLogger.warn("找不到%s!", lib);
				return null;
			}
			var gpk : Gpk = loader.gpk;
			return gpk != null ? gpk.getLBD(key) : null;
		}

		public static function getImg(key : String) : BitmapData {
			var loader : GImgLoader = _loaded[key] as GImgLoader;
			return loader != null ? loader.bitmapData : null;
		}

		public static function getMp3(name : String) : Sound {
			var loader : GMp3Loader = _loaded[name] as GMp3Loader;
			return loader != null ? loader.getSound() : null;
		}

		public static function getXML(key : String) : XML {
			var loader : GXmlLoader = _loaded[key] as GXmlLoader;
			return loader != null ? loader.xml : null;
		}

		public static function getJsonObj(key : String) : Object {
			var loader : GJsonLoader = _loaded[key] as GJsonLoader;
			return loader != null ? loader.jsonObj : null;
		}

		public static function getSheet(key : String, lib : String) : GWorkSheet {
			var loader : GXlsxLoader = _loaded[lib] as GXlsxLoader;
			return loader != null ? loader.getSheet(key) : null;
		}

		public static function getCsvData(key : String) : Vector.<Vector.<String>> {
			var loader : GCsvLoader = _loaded[key] as GCsvLoader;
			return loader != null ? loader.data : null;
		}

		public static function getPlistOb(key : String) : Object {
			var loader : GPlistLoader = _loaded[key] as GPlistLoader;
			return loader != null ? loader.plistObj : null;
		}

		public static function getAtfBD(key : String) : BitmapData {
			var loader : GAtfLoader = _loaded[key] as GAtfLoader;
			return loader != null ? loader.bitmapData : null;
		}

		public static function getClass(key : String, lib : String) : Class {
			var loader : GSwfLoader = _loaded[lib] as GSwfLoader;
			return loader != null ? loader.getClass(key) : null;
		}

		public static function getSprite(key : String, lib : String) : Sprite {
			var loader : GSwfLoader = _loaded[lib] as GSwfLoader;
			return loader != null ? loader.getSprite(key) : null;
		}

		public static function getMC(key : String, lib : String) : MovieClip {
			var loader : GSwfLoader = _loaded[lib] as GSwfLoader;
			return loader != null ? loader.getMC(key) : null;
		}

		public static function getBD(key : String, lib : String) : BitmapData {
			var loader : GSwfLoader = _loaded[lib] as GSwfLoader;
			return loader != null ? loader.getBD(key) : null;
		}

		public static function getSound(key : String, lib : String) : Sound {
			var loader : GSwfLoader = _loaded[lib] as GSwfLoader;
			return loader != null ? loader.getSound(key) : null;
		}
	}
}