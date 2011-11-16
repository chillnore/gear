package gear.core {
	import gear.log4a.GLogger;
	import gear.log4a.LogError;
	import gear.log4a.TraceAppender;
	import gear.net.AssetData;
	import gear.net.RESManager;
	import gear.net.XMLLoader;
	import gear.render.FrameRender;
	import gear.ui.manager.UIManager;
	import gear.ui.monitor.LoadMonitor;
	import gear.ui.skin.ASSkin;
	import gear.ui.theme.BlackTheme;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	/**
	 * 游戏抽象基类
	 * 
	 * @author bright
	 * @version 20110819
	 */
	public class Game extends Sprite {
		/**
		 * @private
		 */
		protected var _res : RESManager;
		/**
		 * @private
		 */
		protected var _libs : XMLLoader;
		/**
		 * @private
		 */
		protected var _load_lm : LoadMonitor;

		private function addedToStageHandler(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.HIGH;
			stage.frameRate = 30;
			stage.stageFocusRect = false;
			stage.showDefaultContextMenu = false;
			GLogger.addAppender(new TraceAppender());
			ASSkin.setTheme(AssetData.AS_LIB, new BlackTheme());
			UIManager.root = this;
			FrameRender.instance.stage = stage;
			_res = RESManager.instance;
			startup();
		}

		/**
		 * 启动游戏-抽象方法
		 */
		protected function startup() : void {
			throw new LogError("you must override startup function!");
		}

		public function Game() {
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
	}
}