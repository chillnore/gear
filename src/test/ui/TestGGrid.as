package test.ui {
	import gear.ui.manager.UIManager;
	import flash.text.TextFormat;

	import gear.core.Game;
	import gear.net.LibData;
	import gear.net.SWFLoader;
	import gear.ui.controls.GGrid;
	import gear.ui.data.GGridData;

	import flash.events.Event;
	import flash.text.TextField;

	/**
	 * @author bright
	 * @version 20111120
	 */
	[SWF(width=550,height=400,backgroundColor=0x333333,frameRate="30")]
	public class TestGGrid extends Game {
		private var _grid : GGrid;

		override protected function startup() : void {
			_res.add(new SWFLoader(new LibData("ui/ui.swf", "ui")));
			_res.addEventListener(Event.COMPLETE, res_complateHandler);
			_res.load();
		}

		private function res_complateHandler(event : Event) : void {
			// addGrid();
			var tf : TextField = new TextField();
			var format : TextFormat = new TextFormat();
			format.font = UIManager.defaultFont;
			format.size = UIManager.defaultSize;
			tf.defaultTextFormat = format;
			tf.textColor = 0xFFFFFF;
			tf.text = "中文abcdABCD";
			addChild(tf);
		}

		protected function addGrid() : void {
			var data : GGridData = new GGridData();
			data.bgSkin = null;
			data.x = data.y = 10;
			data.hgap = data.vgap = 5;
			data.cellData.width = 44;
			data.cellData.height = 44;
			_grid = new GGrid(data);
			addChild(_grid);
		}
	}
}
