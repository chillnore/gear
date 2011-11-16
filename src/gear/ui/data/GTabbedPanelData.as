package gear.ui.data {
	import gear.ui.core.GBaseData;
	import gear.ui.core.ScaleMode;
	/**
	 * @version 20091215
	 * @author bright
	 */
	public class GTabbedPanelData extends GBaseData {
		public var tabData : GTabData;
		public var viewStackData : GBaseData;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GTabbedPanelData = source as GTabbedPanelData;
			if(data == null)
				return;
			data.tabData = (tabData ? tabData.clone() : null);
			data.viewStackData = (viewStackData ? viewStackData.clone() : null);
		}

		public function GTabbedPanelData() {
			tabData = new GTabData();
			viewStackData = new GBaseData();
			scaleMode = ScaleMode.AUTO_SIZE;
			width = 200;
			height = 200;
		}

		override public function clone() : * {
			var data : GTabbedPanelData = new GTabbedPanelData();
			parse(data);
			return data;
		}
	}
}
