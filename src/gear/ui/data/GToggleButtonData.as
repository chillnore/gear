package gear.ui.data {
	import gear.ui.core.GAlign;
	import gear.ui.core.GBaseData;
	import gear.ui.manager.GUIUtil;
	import gear.ui.skin.SkinStyle;
	import gear.ui.skin.tb.IToggleButtonSkin;
	import gear.ui.skin.tb.ToggleButtonSkin;

	import flash.display.DisplayObject;

	/**
	 * 开关按钮控件定义
	 * 
	 * @author bright
	 * @verison 20121105
	 */
	public class GToggleButtonData extends GBaseData {
		public var skin : IToggleButtonSkin;
		public var labelData : GLabelData;
		public var selected : Boolean = false;
		public var textDisabledColor : uint = 0x787878;
		public var textRollOverColor : uint = 0xFFFFFF;
		public var padding : int = 3;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GToggleButtonData = source as GToggleButtonData;
			if (data == null) {
				return;
			}
			data.skin = (skin != null ? skin.clone() : null);
			data.labelData = (labelData ? labelData.clone() : null);
			data.textDisabledColor = textDisabledColor;
			data.textRollOverColor = textRollOverColor;
			data.selected = selected;
		}

		public function GToggleButtonData() {
			var upSkin : DisplayObject = GUIUtil.getSkinBy(SkinStyle.button_upSkin, "ui");
			var overSkin : DisplayObject = GUIUtil.getSkinBy(SkinStyle.button_overSkin, "ui");
			var downSkin : DisplayObject = GUIUtil.getSkinBy(SkinStyle.button_downSkin, "ui");
			var disabledSkin : DisplayObject = GUIUtil.getSkinBy(SkinStyle.button_disabledSkin, "ui");
			var selectedUpSkin : DisplayObject = GUIUtil.getSkinBy(SkinStyle.button_selectedUpSkin, "ui");
			var selectedOverSkin : DisplayObject = GUIUtil.getSkinBy(SkinStyle.button_selectedOverSkin, "ui");
			var selectedDownSkin : DisplayObject = GUIUtil.getSkinBy(SkinStyle.button_selectedDownSkin, "ui");
			var selectedDisabledSkin : DisplayObject = GUIUtil.getSkinBy(SkinStyle.button_selectedDisabledSkin, "ui");
			skin = new ToggleButtonSkin(upSkin, overSkin, downSkin, disabledSkin, selectedUpSkin, selectedOverSkin, selectedDownSkin, selectedDisabledSkin);
			width = 70;
			height = 24;
			labelData = new GLabelData();
			labelData.align = GAlign.CENTER;
		}

		override public function clone() : * {
			var data : GToggleButtonData = new GToggleButtonData();
			parse(data);
			return data;
		}
	}
}
