package gear.core {
	import gear.gui.utils.GUIUtil;
	import gear.log4a.GLogError;
	import gear.log4a.GLogger;
	import gear.log4a.GTraceAppender;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * 游戏抽象基类
	 * 
	 * @example
	 * public class MyGame extends Game{
	 *   override protected function startup():void{
	 *     // 启动游戏
	 *   }
	 * }
	 * @author bright
	 * @version 20130314
	 */
	public class Game extends Sprite {
		private function addedToStageHandler(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			GLogger.addAppender(GTraceAppender.instance);
			GUIUtil.init(stage);
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
