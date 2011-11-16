package gear.net {
	import gear.log4a.GLogger;
	import gear.log4a.LogError;
	import gear.utils.DictionaryUtil;

	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * 资源管理器
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public final class RESManager extends EventDispatcher {
		private static var _creating : Boolean = false;
		private static var _instance : RESManager;
		private static var _list : Array = new Array;
		private static var _wait : Dictionary = new Dictionary(true);
		private static var _loaded : Dictionary = new Dictionary(true);
		private var _model : LoadModel;

		private function init() : void {
			_model = new LoadModel();
		}

		private function loadNext() : void {
			var loader : ALoader;
			while (_model.hasFree()) {
				if (_list.length == 0)
					return;
				loader = ALoader(_list.shift());
				_model.add(loader.loadData);
				loader.addEventListener(Event.COMPLETE, completeHandler);
				loader.addEventListener(ErrorEvent.ERROR, errorHandler);
				loader.load();
			}
		}

		private function completeHandler(event : Event) : void {
			var loader : ALoader = ALoader(event.target);
			loader.removeEventListener(Event.COMPLETE, completeHandler);
			loader.removeEventListener(ErrorEvent.ERROR, errorHandler);
			_model.remove(loader.loadData);
			delete _wait[loader.key];
			_loaded[loader.key] = loader;
			if (_list.length > 0) {
				loadNext();
			} else if (DictionaryUtil.isEmpty(_wait)) {
				_model.end();
				GLogger.info("RESManager load all done");
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}

		private function errorHandler(event : ErrorEvent) : void {
			var loader : ALoader = ALoader(event.target);
			loader.removeEventListener(Event.COMPLETE, completeHandler);
			loader.removeEventListener(ErrorEvent.ERROR, errorHandler);
			_model.remove(loader.loadData);
			delete _wait[loader.key];
			if (_list.length > 0) {
				loadNext();
			} else if (DictionaryUtil.isEmpty(_wait)) {
				_model.end();
				GLogger.info("RESManager load all done");
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}

		/**
		 * 构造函数
		 * 
		 * @throws LogError 不能被实例化
		 * @see RESManager#instance
		 */
		public function RESManager() {
			if (!_creating) {
				throw (new LogError("Class cannot be instantiated.Use RESManager.instance instead."));
			}
			init();
		}

		/**
		 * 获得RESManager单例
		 * 
		 * @return anager单例
		 */
		public static function get instance() : RESManager {
			if (_instance == null) {
				_creating = true;
				_instance = new RESManager();
				_creating = false;
			}
			return _instance;
		}

		/**
		 * 获得皮肤-支持BitmapData,Sprite,MovieClip基类的元件
		 * 
		 * @param asset 元件数据
		 * @return 皮肤
		 * @see gear.net.SWFLoader#getSkin()
		 */
		public static function getSkin(asset : AssetData) : Sprite {
			var loader : SWFLoader = _loaded[asset.libId] as SWFLoader;
			if (loader == null) {
				return null;
			}
			return loader.getSkin(asset.className);
		}

		/**
		 * 获得Sprite
		 * 
		 * @param asset 元件定义
		 * @return Spte		 * @see gear.net.SWFLoader#getSprite()
		 */
		public static function getSprite(asset : AssetData) : Sprite {
			var loader : SWFLoader = _loaded[asset.libId] as SWFLoader;
			if (loader == null) {
				return null;
			}
			return loader.getSprite(asset.className);
		}

		/**
		 * 获得MC
		 * 
		 * @param asset 元件定义
		 * @return MC
		 * @see gear.net.SWFLoader#getMC()
		 */
		public static function getMC(asset : AssetData) : MovieClip {
			var loader : SWFLoader = _loaded[asset.libId] as SWFLoader;
			if (loader == null) {
				return null;
			}
			return loader.getMC(asset.className);
		}

		/**
		 * 获得位图
		 * 
		 * @param asset 元件定义
		 * @return 位图
		 * @see ar.net.SWFLoader#getBD()
		 */
		public static function getBD(asset : AssetData) : BitmapData {
			var loader : SWFLoader = _loaded[asset.libId] as SWFLoader;
			if (loader == null) {
				return null;
			}
			return loader.getBD(asset.className);
		}

		/**
		 * 获得声音
		 * 
		 * @param asset 元件定义
		 * @return 声音
		 *see gearet.SWFLoader#getSound()
		 */
		public static function getSound(asset : AssetData) : Sound {
			var loader : SWFLoader = _loaded[asset.libId] as SWFLoader;
			if (loader == null) {
				return null;
			}
			return loader.getSound(asset.className);
		}

		/**
		 * 获得XML
		 * 
		 * @param key 库键
		 * @return XML
		 * ee gear.neXMLLoader#getXML()
		 */
		public static function getXML(key : String) : XML {
			var loader : XMLLoader = _loaded[key] as XMLLoader;
			if (loader == null) {
				return null;
			}
			return loader.getXML();
		}

		/**
		 * 获得Mp3
		 * 
		 * @param key 库键
		 * @return Mp3
		 * @s gear.net.MPoader#getMp3()
		 */
		public static function getMp3(key : String) : Sound {
			var loader : MP3Loader = _loaded[key] as MP3Loader;
			if (loader == null) {
				return null;
			}
			return loader.getSound();
		}

		public static function getByteArray(key : String) : ByteArray {
			var loader : RESLoader = _loaded[key] as RESLoader;
			if (loader == null) {
				return null;
			}
			return loader.getByteArray();
		}

		/**
		 * 获得ByteArray
		 * 
		 * @param asset 元件定义
		 * @return ByteArray
		 
		public stac function getByteArray(key : String) : ByteArray {
		var loader : RESLoader = _loaded[key] as RESLoader;
		if(loader == null) {
		return null;
		}
		return loader.getByteArray();
		}

		/**
		 * 加入加载器
		 * 
		 * @param loader 加载器
		 * @see gear.net.XMLLoader
		 * @see gear.net.SWFLoader
		 * @see gear.net.PNGLoader
		 * @see gear.net.MP3Loader
		 */
		public function add(loader : ALoader) : void {
			var key : String = loader.key;
			if (loader.isLoaded) {
				_loaded[key] = loader;
				return;
			}
			if (_loaded[key] != null) {
				return;
			}
			if (_wait[key] != null) {
				return;
			}
			_list.push(loader);
			_wait[key] = loader;
			return;
		}

		/**
		 * 获得加载模型
		 * 
		 * @return 加载模型
		 * @see ar.net.LoadModel		 */
		public function get model() : LoadModel {
			return _model;
		}

		/**
		 * @inheritDoc
		 */
		public function load() : void {
			if (_list.length == 0) {
				_model.end();
				dispatchEvent(new Event(Event.COMPLETE));
				return;
			}
			_model.reset(_list.length);
			loadNext();
		}
	}
}