package gear.net {
	import gear.log4a.GLogger;
	import gear.utils.GStringUtil;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
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
	 * @version 20101015
	 */
	public class SWFLoader extends RESLoader {
		private var _loader : Loader;
		private var _domain : ApplicationDomain;

		override protected function onComplete() : void {
			_loader = new Loader();
			var context : LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			try {
				context["allowLoadBytesCodeExecution"] = true;
			} catch(e : Error) {
			}
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			_loader.loadBytes(_byteArray, context);
		}

		private function completeHandler(event : Event) : void {
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			_domain = LoaderInfo(event.currentTarget).applicationDomain;
			_isLoadding = false;
			_isLoaded = true;
			GLogger.info(GStringUtil.format("load {0} complete", _libData.url));
			dispatchEvent(new Event(Event.COMPLETE));
		}

		/**
		 * @inheritDoc
		 */
		public function SWFLoader(data : LibData) {
			super(data);
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

		/**
		 * 获得皮肤-支持BitmapData,Sprite,MovieClip基类的元件
		 * 
		 * @param className 类名称
		 * @return 		 */
		public function getSkin(className : String) : Sprite {
			var assetClass : Class = getClass(className);
			if (assetClass == null) {
				return null;
			}
			var result : Object = new assetClass();
			if (result is BitmapData) {
				var sprite : Sprite = new Sprite();
				sprite.addChild(new Bitmap(BitmapData(result)));
				return sprite;
			} else if (result is Sprite) {
				return Sprite(result);
			} else {
				return null;
			}
		}

		/**
		 * 获得Sprite
		 * 
		 * @param asset 元件定义
		 * @return Spte		 */
		public function getSprite(className : String) : Sprite {
			var assetClass : Class = getClass(className);
			if (assetClass == null) {
				return null;
			}
			var sprite : Sprite = new assetClass() as Sprite;
			if (sprite == null) {
				GLogger.warn(GStringUtil.format("{0} isn't a Sprite in {1}", className, _libData.url));
			}
			return sprite;
		}

		/**
		 * 获得MovieClip
		 * 
		 * @param asset 元件定义
		 * @return Movilip	 */
		public function getMC(className : String) : MovieClip {
			var assetClass : Class = getClass(className);
			if (assetClass == null) {
				return null;
			}
			var mc : MovieClip = new assetClass() as MovieClip;
			if (mc == null) {
				GLogger.warn(GStringUtil.format("{0} isn't a MovieClip in {1}", className, _libData.url));
			}
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
				GLogger.warn(GStringUtil.format("{0} isn't a BitmapData in {1}", className, _libData.url));
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
				GLogger.warn(GStringUtil.format("{0} isn't a Sound in {1}", className, _libData.url));
			}
			return sound;
		}
	}
}