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
			if(loader.state==GLoadState.COMPLETE){
				_loaded[loader.key]=loader;
			}
			var group:GLoadGroup;
			var finishs:Vector.<GLoadGroup>=new Vector.<GLoadGroup>();
			for each (group in groups) {
				group.loadNext(loader);
				if(group.isFinish){
					finishs.push(group);
				}
			}
			for each(group in finishs){
				index=groups.indexOf(group);
				if(index!=-1){
					groups.splice(index,1);
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
		 * @param automatch 自动匹配文件类型
		 * @return ALoader 抽象加载器
		 */
		internal static function create(url : String) : AGLoader {
			var key : String = GFileType.getKey(url);
			var loader : AGLoader = _created[key];
			if (loader != null) {
				return loader;
			}
			var type : int = GFileType.getType(url);
			switch(type) {
				case GFileType.GPK:
					loader = new GpkLoader(url);
					break;
				case GFileType.SWF:
					loader = new GSwfLoader(url);
					break;
				case GFileType.PNG:
					loader = new GImgLoader(url);
					break;
				case GFileType.JPG:
					loader = new GImgLoader(url);
					break;
				case GFileType.MP3:
					loader = new GMp3Loader(url);
					break;
				case GFileType.XML:
					loader = new GXmlLoader(url);
					break;
				case GFileType.JSON:
					loader = new GJsonLoader(url);
					break;
				case GFileType.XLSX:
					loader = new GXlsxLoader(url);
					break;
				case GFileType.PSD:
					loader = new GPsdLoader(url);
					break;
				case GFileType.PLIST:
					loader = new GPlistLoader(url);
					break;
				default:
					loader = new GBinLoader(url);
					break;
			}
			_created[key] = loader;
			return loader;
		}
		
		internal static function startLoad(loader:AGLoader) : void {
			if (_loadings.length < MAX) {
				_loadings.push(loader);
				loader.load();
			} else {
				_waits.push(loader);
				loader.wait();
			}
		}

		public static function load(url : String, onLoaded : Function, onFailed : Function = null) : void {
			var loader : AGLoader = create(url);
			if (loader.state != GLoadState.NONE) {
				return;
			}
			loader.onLoaded = onLoaded;
			loader.onFailed = onFailed;
			startLoad(loader);
		}
		
		public static function unload(key:String):void{
			var loader:AGLoader=_loaded[key];
			if(loader!=null){
				//loader.unload();
				delete _loaded[key];
			}
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
				GLogger.warn("在"+lib+"中找不到"+key);
				return null;
			}
			var gpk : Gpk = loader.gpk;
			return gpk != null ? gpk.getLBD(key) : null;
		}

		public static function getImg(key : String) : BitmapData {
			var loader : GImgLoader = _loaded[key] as GImgLoader;
			return loader != null ? loader.bitmap.bitmapData : null;
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

		public static function getPlistOb(key : String) : Object {
			var loader : GPlistLoader = _loaded[key] as GPlistLoader;
			return loader != null ? loader.plistObj : null;
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