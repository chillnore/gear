package gear.ui.data {
	import gear.ui.core.GAlign;
	import gear.ui.core.GBaseData;

	import flash.display.DisplayObject;

	/**
	 * 标题栏组件
	 * 
	 * @author bright
	 */
	public class GTitleBarData extends GBaseData {
		public var bgSkin : DisplayObject;
		public var closeButtonData : GButtonData;
		public var labelData : GLabelData;

		public function GTitleBarData() {
			width = 100;
			height = 30;
			labelData = new GLabelData();
			labelData.align = new GAlign(-1, -1, -1, -1, 0, 0);
		}
	}
}
