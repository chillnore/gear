package gear.ui.game {
	import gear.motion.easing.Cubic;
	import gear.ui.color.GColor;
	import gear.ui.core.GBaseData;
	import gear.ui.manager.GUIUtil;
	import gear.ui.skin.ASSkin;
	import gear.ui.skin.BarSkin;
	import gear.ui.skin.SkinStyle;
	import gear.utils.GColorUtil;

	import flash.display.DisplayObject;

	/**
	 * 血条组件定义
	 * 
	 * @author bright
	 * @version 20120627
	 */
	public class BloodBarData extends GBaseData {
		public var trackSkin : DisplayObject;
		public var oldBarSkin : BarSkin;
		public var barSkin : BarSkin;
		public var padding : int;
		public var ease : Function;

		public function BloodBarData() {
			trackSkin = GUIUtil.getSkin(SkinStyle.progressBar_trackSkin, ASSkin.AS_LIB);
			oldBarSkin = new BarSkin(GColorUtil.adjustBrightness(GColor.GREEN, 127), 0.7);
			barSkin = new BarSkin(GColor.GREEN);
			padding = 0;
			width = 100;
			height = 10;
			ease = Cubic.easeIn;
		}
	}
}
