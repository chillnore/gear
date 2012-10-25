package gear.net {
	import gear.log4a.GLogger;
	import gear.utils.GStringUtil;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	/**
	 * SWF文件加载器
	 * 
	 * @author bright
	 * @version 20121025
	 */
	internal final class SwfLoader extends BinLoader {
		private var _loader : Loader;
		private var _domain : ApplicationDomain;
		private var _content : DisplayObject;
		private var _swfWidth : int;
		private var _swfHeight : int;

		override protected function decode() : void {
			_loader = new Loader();
			var context : LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
			context.allowCodeImport = true;
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			_loader.loadBytes(_byteArray, context);
		}

		private function completeHandler(event : Event) : void {
			var loaderInfo : LoaderInfo = LoaderInfo(event.currentTarget);
			loaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			_domain = loaderInfo.applicationDomain;
			_content = loaderInfo.content;
			_swfHeight = loaderInfo.height;
			_swfWidth = loaderInfo.width;
			onComplete();
		}

		/**
		 * SwfLoader加载器
		 * 
		 * @param url
		 * @param key
		 */
		public function SwfLoader(url : String, key : String) {
			super(url, key);
		}

		public function get content() : DisplayObject {
			return _content;
		}

		public function get swfWidth() : int {
			return _swfWidth;
		}

		public function get swfHeight() : int {
			return _swfHeight;
		}

		public function get loader() : Loader {
			return _loader;
		}

		/**
		 * getClass 从SWF中获得类
		 * 
		 * @param className 类名称
		 * @return Class 类
		 */
		public function getClass(className : String) : Class {
			if (!_domain.hasDefinition(className)) {
				return null;
			}
			var assetClass : Class = _domain.getDefinition(className) as Class;
			return assetClass;
		}

		public function getSkinBy(key : String) : DisplayObject {
			var assetClass : Class = getClass(key);
			if (assetClass == null) {
				return null;
			}
			var result : * = new assetClass();
			if (result is BitmapData) {
				return  new Bitmap(result);
			} else if (result is Sprite) {
				return Sprite(result);
			}
			return null;
		}

		/**
		 * 获得Sprite
		 * 
		 * @param asset 元件定义
		 * @return Sprite
		 */
		public function getSprite(className : String) : Sprite {
			var assetClass : Class = getClass(className);
			if (assetClass == null) {
				return null;
			}
			var sprite : Sprite = new assetClass() as Sprite;
			if (sprite == null) {
				GLogger.warn(GStringUtil.format("{0} isn't a Sprite in {1}", className, _key));
			}
			return sprite;
		}

		/**
		 * 获得MovieClip
		 * 
		 * @param asset 元件定义
		 * @return Movilip	     */
		public function getMC(className : String) : MovieClip {
			var assetClass : Class = getClass(className);
			if (assetClass == null) {
				return null;
			}
			var mc : MovieClip = new assetClass() as MovieClip;
			if (mc == null) {
				GLogger.warn(GStringUtil.format("{0} isn't a MovieClip in {1}", className, _key));
			}
			mc.stop();
			return mc;
		}

		/**
		 * 获得BitmapData
		 * 
		 * @param asset 元件定义
		 * @return Bitmapta 位图
		 */
		public function getBD(className : String) : BitmapData {
			var assetClass : Class = getClass(className);
			if (assetClass == null) {
				return null;
			}
			var bd : BitmapData = new assetClass() as BitmapData;
			if (bd == null) {
				GLogger.warn(GStringUtil.format("{0} isn't a BitmapData in {1}", className, _key));
			}
			return bd;
		}

		/**
		 * 获得Sound
		 * 
		 * @param asset 元件定义
		 * @return Sound
		 */
		public function getSound(className : String) : Sound {
			var assetClass : Class = getClass(className);
			if (assetClass == null)
				return null;
			var sound : Sound = new assetClass() as Sound;
			if (sound == null) {
				GLogger.warn(GStringUtil.format("{0} isn't a Sound in {1}", className, _key));
			}
			return sound;
		}
	}
}