package gear.core {
	import gear.log4a.GLogError;
	import gear.log4a.GLogger;
	import gear.log4a.GTraceAppender;
	import gear.render.FrameRender;
	import gear.ui.manager.GUIUtil;
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
	 * @example
	 * public class MyGame extends Game{
	 *   override protected function startup():void{
	 *     // start your game
	 *   }
	 * }
	 * @author bright
	 * @version 20121105
	 */
	public class Game extends Sprite {
		/**
		 * @private
		 */
		protected var _load_lm : LoadMonitor;

		private function addedToStageHandler(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.HIGH;
			stage.frameRate = 32;
			stage.stageFocusRect = false;
			stage.showDefaultContextMenu = false;
			GLogger.addAppender(new GTraceAppender());
			ASSkin.setTheme(ASSkin.AS_LIB, new BlackTheme());
			GUIUtil.root = this;
			FrameRender.instance.stage = stage;
			startup();
		}

		/**
		 * 启动游戏-抽象方法
		 */
		protected function startup() : void {
			throw new GLogError("you must override startup function!");
		}

		public function Game() {
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
	}
}
