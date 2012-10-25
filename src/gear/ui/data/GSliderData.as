package gear.ui.data {
	import gear.ui.core.GBaseData;
	import gear.ui.core.GScaleMode;
	import gear.ui.manager.UIManager;
	import gear.ui.skin.SkinStyle;

	import flash.display.DisplayObject;

	/**
	 * Game Slider Data
	 * 
	 * @author BrightLi
	 * @version 20120424
	 */
	public class GSliderData extends GBaseData {
		public var trackSkin : DisplayObject;
		public var barSkin : DisplayObject;
		public var thumbSkin : DisplayObject;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GSliderData = source as GSliderData;
			if (data == null) {
				return;
			}
			data.trackSkin = UIManager.cloneSkin(trackSkin);
			data.barSkin = UIManager.cloneSkin(barSkin);
			data.thumbSkin = UIManager.cloneSkin(thumbSkin);
		}

		public function GSliderData() {
			trackSkin = UIManager.getSkinBy(SkinStyle.slider_trackSkin, "ui");
			barSkin = UIManager.getSkinBy(SkinStyle.slider_barSkin, "ui");
			thumbSkin = UIManager.getSkinBy(SkinStyle.slider_thumbSkin, "ui");
			width = 100;
			height = 10;
			scaleMode = GScaleMode.WIDTH_ONLY;
		}

		override public function clone() : * {
			var data : GSliderData = new GSliderData();
			parse(data);
			return data;
		}
	}
}
