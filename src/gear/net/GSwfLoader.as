package gear.net {
	import gear.log4a.GLogger;
	import gear.utils.GStringUtil;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import flash.system.ImageDecodingPolicy;
	import flash.system.LoaderContext;

	/**
	 * SWF文件加载器
	 * 
	 * @author bright
	 * @version 20121124
	 */
	internal final class GSwfLoader extends GBinLoader {
		private var _domain : ApplicationDomain;
		private var _content : DisplayObject;

		override protected function decode() : void {
			var loader : Loader = new Loader();
			var context : LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
			context.allowCodeImport = true;
			if (Capabilities.playerType == "Desktop") {
				context.allowLoadBytesCodeExecution = true;
			}
			context.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.loadBytes(_data, context);
		}

		private function completeHandler(event : Event) : void {
			var loaderInfo : LoaderInfo = LoaderInfo(event.currentTarget);
			loaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			_domain = loaderInfo.applicationDomain;
			_content = loaderInfo.content;
			_data.clear();
			complete();
		}

		/**
		 * SwfLoader加载器
		 * 
		 * @param url
		 * @param key
		 */
		public function GSwfLoader(url : String) {
			super(url);
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