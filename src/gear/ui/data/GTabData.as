package gear.ui.data {
	import gear.net.AssetData;
	import gear.ui.core.GAlign;
	import gear.ui.core.GBaseData;
	import gear.ui.core.ScaleMode;

	/**
	 * @version 20091215
	 * @author bright
	 */
	public class GTabData extends GBaseData {
		public var upAsset : AssetData = new AssetData("GTab_upSkin");
		public var overAsset : AssetData = new AssetData("GTab_overSkin");
		public var disabledAsset : AssetData = new AssetData("GTab_disabledSkin");
		public var selectedUpAsset : AssetData = new AssetData("GTab_selectedUpSkin");
		public var selectedDisabledAsset : AssetData = new AssetData("GTab_selectedDisabledSkin");
		public var labelData : GLabelData;
		public var selected : Boolean = false;
		public var padding : int = 7;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GTabData = source as GTabData;
			if (data == null)
				return;
			data.upAsset = upAsset;
			data.overAsset = overAsset;
			data.disabledAsset = disabledAsset;
			data.selectedUpAsset = selectedUpAsset;
			data.selectedDisabledAsset = selectedDisabledAsset;
			data.labelData = (labelData ? labelData.clone() : null);
			data.selected = selected;
			data.padding = padding;
		}

		public function GTabData() {
			scaleMode = ScaleMode.AUTO_WIDTH;
			width = 60;
			height = 22;
			labelData = new GLabelData();
			labelData.color.upColor = 0xBEBEBE;
			labelData.color.overColor = 0xFFFFFF;
			labelData.color.selectedColor = 0xEFEFEF;
			labelData.align = new GAlign(-1, -1, -1, -1, 0, 0);
		}

		override public function clone() : * {
			var data : GTabData = new GTabData();
			parse(data);
			return data;
		}
	}
}
