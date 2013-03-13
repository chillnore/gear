package gear.core {
	import gear.gui.utils.GUIUtil;
	import gear.log4a.GLogError;
	import gear.log4a.GLogger;
	import gear.log4a.GTraceAppender;
	import gear.render.GFrameRender;

	import flash.display.Sprite;
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
	 * @version 20121204
	 */
	public class Game extends Sprite {
		private function addedToStageHandler(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			// stage.showDefaultContextMenu = false;
			GUIUtil.init(stage);
			GLogger.addAppender(new GTraceAppender());
			GFrameRender.instance.stage = stage;
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
