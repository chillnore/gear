package gear.ui.data {
	import gear.ui.core.GBaseData;
	import gear.ui.core.GScaleMode;
	import gear.ui.manager.GUIUtil;
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
			data.trackSkin = GUIUtil.cloneSkin(trackSkin);
			data.barSkin = GUIUtil.cloneSkin(barSkin);
			data.thumbSkin = GUIUtil.cloneSkin(thumbSkin);
		}

		public function GSliderData() {
			trackSkin = GUIUtil.getSkin(SkinStyle.slider_trackSkin, "ui");
			barSkin = GUIUtil.getSkin(SkinStyle.slider_barSkin, "ui");
			thumbSkin = GUIUtil.getSkin(SkinStyle.slider_thumbSkin, "ui");
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
