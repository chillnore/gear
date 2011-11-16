package gear.ui.data {
	import gear.net.AssetData;
	import gear.ui.core.GBaseData;
	import gear.ui.skin.SkinStyle;
	/**
	 * @version 20091215
	 * @author bright
	 */
	public class GRadioButtonData extends GBaseData {
		public var upAsset : AssetData;
		public var upIcon : AssetData;
		public var selectedUpIcon : AssetData;
		public var labelData : GLabelData;
		public var selected : Boolean = false;
		public var padding : int = 2;
		public var hGap : int = 2;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GRadioButtonData = source as GRadioButtonData;
			if(data == null)
				return;
			data.upAsset = upAsset;
			data.upIcon = upIcon;
			data.selectedUpIcon = selectedUpIcon;
			data.labelData = labelData.clone();
			data.selected = selected;
			data.padding = padding;
			data.hGap = hGap;
		}

		public function GRadioButtonData() {
			upAsset = new AssetData(SkinStyle.emptySkin, AssetData.AS_LIB);
			upIcon = new AssetData(SkinStyle.radioButton_upIcon);
			selectedUpIcon = new AssetData(SkinStyle.radioButton_selectedUpIcon);
			labelData = new GLabelData();
			width = 70;
			height = 18;
		}

		override public function clone() : * {
			var data : GRadioButtonData = new GRadioButtonData();
			parse(data);
			return data;
		}
	}
}
