package gear.net {
	import gear.log4a.GLogError;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * Game Load Util 游戏资源管理器
	 * 
	 * @author bright
	 * @version 20121105
	 */
	public final class GLoadUtil {
		private static var _created : Dictionary = new Dictionary();
		private static var _loaded : Dictionary = new Dictionary();

		/**
		 * 构造函数
		 * 
		 * @throws LogError 不能被实例化
		 */
		public function GLoadUtil() {
			throw (new GLogError("Class cannot be instantiated"));
		}

		/**
		 * 创建加载器-工厂模式
		 * 
		 * @example
		 * var loader:ALoader=GLoadUtil.create("assets/ui.swf");
		 * loader.addEventListener(Event.COMPLETE,completeHandler);
		 * loader.load();
		 * 
		 * @param url URL地址
		 * @param key 别名
		 * @return ALoader 抽象加载器
		 */
		public static function create(url : String, key : String = null) : ALoader {
			if (key == null) {
				key = FileType.getKey(url);
			}
			var loader : ALoader = _created[key];
			if (loader != null) {
				return loader;
			}
			var type : int = FileType.getType(url);
			switch(type) {
				case FileType.SWF:
					loader = new SwfLoader(url, key);
					break;
				case FileType.PNG:
					loader = new ImgLoader(url, key);
					break;
				case FileType.JPG:
					loader = new ImgLoader(url, key);
					break;
				case FileType.MP3:
					loader = new MP3Loader(url, key);
					break;
				case FileType.XML:
					loader = new XMLLoader(url, key);
					break;
				case FileType.XLSX:
					loader = new XlsxLoader(url, key);
					break;
				case FileType.PLIST:
					loader = new PlistLoader(url, key);
					break;
				default:
					loader = new BinLoader(url, key);
					break;
			}
			_created[key] = loader;
			return loader;
		}

		public static function setLoaded(value : ALoader) : void {
			_loaded[value.key] = value;
		}

		public static function isLoaded(key : String) : Boolean {
			return _loaded[key] != null ;
		}

		public static function getClass(key : String, lib : String) : Class {
			var loader : SwfLoader = _loaded[lib] as SwfLoader;
			if (loader == null) {
				return null;
			}
			return loader.getClass(key);
		}

		/**
		 * 获得皮肤-支持BitmapData,Sprite,MovieClip基类的元件
		 * 
		 * @param key
		 * @param lib
		 * @return 皮肤
		 * @see gear.net.SWFLoader#getSkinBy()
		 */
		public static function getSkin(key : String, lib : String) : DisplayObject {
			var loader : SwfLoader = _loaded[lib] as SwfLoader;
			if (loader == null) {
				return null;
			}
			return loader.getSkinBy(key);
		}

		/**
		 * 获得Sprite
		 * 
		 * @param asset 元件定义
		 * @return Sprite
		 * @see gear.net.SWFLoader#getSprite()
		 */
		public static function getSprite(key : String, lib : String) : Sprite {
			var loader : SwfLoader = _loaded[lib] as SwfLoader;
			if (loader == null) {
				return null;
			}
			return loader.getSprite(key);
		}

		/**
		 * 获得MC
		 * 
		 * @param asset 元件定义
		 * @return MC
		 * @see gear.net.SWFLoader#getMC()
		 */
		public static function getMC(key : String, lib : String) : MovieClip {
			var loader : SwfLoader = _loaded[lib] as SwfLoader;
			if (loader == null) {
				return null;
			}
			return loader.getMC(key);
		}

		/**
		 * 获得位图
		 * 
		 * @param key 类名
		 * @param lib 库名
		 * @return 位图
		 */
		public static function getBD(key : String, lib : String) : BitmapData {
			var loader : SwfLoader = _loaded[lib] as SwfLoader;
			if (loader == null) {
				return null;
			}
			return loader.getBD(key);
		}

		/**
		 * 获得声音
		 * 
		 * @param key 类名
		 * @param lib 库名
		 * @return 声音
		 */
		public static function getSound(key : String, lib : String) : Sound {
			var loader : SwfLoader = _loaded[lib] as SwfLoader;
			if (loader == null) {
				return null;
			}
			return loader.getSound(key);
		}

		public static function getImg(lib : String) : Bitmap {
			var loader : ImgLoader = _loaded[lib] as ImgLoader;
			if (loader == null) {
				return null;
			}
			return loader.bitmap;
		}

		/**
		 * 获得XML
		 * 
		 * @param lib 库名
		 * @return XML
		 * @see gear.neXMLLoader#getXML()
		 */
		public static function getXML(lib : String) : XML {
			var loader : XMLLoader = _loaded[lib] as XMLLoader;
			if (loader == null) {
				return null;
			}
			return loader.xml;
		}

		/**
		 * 获得Mp3
		 * 
		 * @param lib 库名
		 * @return Mp3
		 */
		public static function getMp3(lib : String) : Sound {
			var loader : MP3Loader = _loaded[lib] as MP3Loader;
			if (loader == null) {
				return null;
			}
			return loader.getSound();
		}

		/**
		 * 获得Excel表格
		 * 
		 * @param lib 库名
		 * @param name 表名
		 * 
		 * @return WorkSheet
		 * 
		 * @see gear.net.WorkSheet
		 */
		public static function getSheet(lib : String, name : String) : WorkSheet {
			var loader : XlsxLoader = _loaded[lib] as XlsxLoader;
			if (loader == null) {
				return null;
			}
			return loader.getSheet(name);
		}

		/**
		 * 获得Plist Object
		 * 
		 * @param lib 库名
		 * 
		 * @return Object
		 * 
		 * @see gear.net.PlistLoader
		 */
		public static function getPlistOb(lib : String) : Object {
			var loader : PlistLoader = _loaded[lib] as PlistLoader;
			if (loader == null) {
				return null;
			}
			return loader.plistObj;
		}

		/**
		 * 获得ByteArray
		 * 
		 * @param asset 元件定义
		 * @return ByteArray
		 */
		public static function getByteArray(lib : String) : ByteArray {
			var loader : BinLoader = _loaded[lib] as BinLoader;
			if (loader == null) {
				return null;
			}
			return loader.getByteArray();
		}
	}
}