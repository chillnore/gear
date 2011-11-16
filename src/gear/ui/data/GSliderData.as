package gear.ui.data {
	import gear.net.AssetData;
	import gear.ui.core.GBaseData;
	import gear.ui.core.ScaleMode;
	import gear.ui.skin.SkinStyle;
	/**
	 * Game Slider Data
	 * 
	 * @author BrightLi
	 * @version 20100712
	 */
	public class GSliderData extends GBaseData {
		public var trackAsset : AssetData;
		public var barAsset : AssetData;
		public var thumbAsset : AssetData;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GSliderData = source as GSliderData;
			if(data == null)
				return;
			data.trackAsset = trackAsset;
			data.barAsset = barAsset;
			data.thumbAsset = thumbAsset;
		}

		public function GSliderData() {
			trackAsset = new AssetData(SkinStyle.slider_trackSkin);
			barAsset = new AssetData(SkinStyle.slider_barSkin);
			thumbAsset = new AssetData(SkinStyle.slider_thumbSkin);
			width = 100;
			height = 10;
			scaleMode = ScaleMode.WIDTH_ONLY;
		}

		override public function clone() : * {
			var data : GSliderData = new GSliderData();
			parse(data);
			return data;
		}
	}
}
