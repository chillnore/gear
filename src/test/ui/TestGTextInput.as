package test.ui {
	import gear.core.Game;
	import gear.ui.controls.GTextInput;
	import gear.ui.data.GTextInputData;

	/**
	 * @author bright
	 * @version 20111121
	 */
	[SWF(width=550,height=400,backgroundColor=0x333333,frameRate="30")]
	public class TestGTextInput extends Game {
		override protected function startup() : void {
			var data : GTextInputData = new GTextInputData();
			data.allowIME = true;
			var ti : GTextInput = new GTextInput(data);
			addChild(ti);
		}
	}
}
