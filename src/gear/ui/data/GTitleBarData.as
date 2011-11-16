package gear.ui.data {
	import gear.net.AssetData;
	import gear.ui.core.GAlign;
	import gear.ui.core.GBaseData;

	/**
	 * @author bright
	 */
	public class GTitleBarData extends GBaseData {
		public var bgAsset : AssetData = new AssetData("GTitleBar_bgSkin");
		public var closeButtonData : GButtonData = new GButtonData();
		public var labelData : GLabelData;

		public function GTitleBarData() {
			width = 100;
			height = 30;
			labelData = new GLabelData();
			labelData.align = new GAlign(10, -1, -1, -1, -1, 0);
		}
	}
}
