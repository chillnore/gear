package test.ui {
	import gear.core.Game;
	import gear.net.LibData;
	import gear.net.SWFLoader;
	import gear.ui.controls.GLabel;
	import gear.ui.data.GLabelData;

	import flash.events.Event;

	/**
	 * @author bright
	 * @version 20111121
	 */
	[SWF(width=550,height=400,backgroundColor=0x333333,frameRate="30")]
	public class TestGLabel extends Game {
		override protected function startup() : void {
			_res.add(new SWFLoader(new LibData("ui/ui.swf", "ui")));
			_res.addEventListener(Event.COMPLETE, res_complateHandler);
			_res.load();
		}

		private function res_complateHandler(event : Event) : void {
			addGLabel();
		}

		protected function addGLabel() : void {
			var data : GLabelData = new GLabelData();
			data.text = "中文abcdefgABCDEFG";
			addChild(new GLabel(data));
		}
	}
}
