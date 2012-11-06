package gear.ui.data {
	import flash.display.DisplayObject;
	import gear.ui.core.GBaseData;
	import gear.ui.core.GScaleMode;
	import gear.ui.manager.GUIUtil;
	import gear.ui.skin.btn.ButtonSkin;


	/**
	 * GStepper 步进器控件定义
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class GStepperData extends GBaseData {
		public var labelData : GLabelData;
		// 向上按钮定义
		public var upArrowData : GButtonData;
		// 向下按钮定义
		public var downArrowData : GButtonData;
		// 输入框定义
		public var textInputData : GTextInputData;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GStepperData = source as GStepperData;
			if (data == null) {
				return;
			}
			data.labelData = labelData.clone();
			data.upArrowData = (upArrowData ? upArrowData.clone() : null);
			data.downArrowData = (downArrowData ? downArrowData.clone() : null);
			data.textInputData = (textInputData ? textInputData.clone() : null);
		}

		public function GStepperData() {
			labelData = new GLabelData();
			upArrowData = new GButtonData();
			var upSkin : DisplayObject = GUIUtil.getSkin("GSpinner_upArrow_upSkin","ui");
			var overSkin : DisplayObject = GUIUtil.getSkin("GSpinner_upArrow_overSkin","ui");
			var downSkin : DisplayObject = GUIUtil.getSkin("GSpinner_upArrow_downSkin","ui");
			var disabledSkin : DisplayObject = GUIUtil.getSkin("GSpinner_upArrow_disabledSkin","ui");
			upArrowData.skin = new ButtonSkin(upSkin, overSkin, downSkin, disabledSkin);
			upArrowData.scaleMode = GScaleMode.NONE;
			upArrowData.width = 18;
			upArrowData.height = 11;
			downArrowData = new GButtonData();
			upSkin = GUIUtil.getSkin("GSpinner_downArrow_upSkin","ui");
			overSkin = GUIUtil.getSkin("GSpinner_downArrow_overSkin","ui");
			downSkin = GUIUtil.getSkin("GSpinner_downArrow_downSkin","ui");
			disabledSkin = GUIUtil.getSkin("GSpinner_downArrow_disabledSkin","ui");
			downArrowData.skin = new ButtonSkin(upSkin, overSkin, downSkin, disabledSkin);
			downArrowData.scaleMode = GScaleMode.NONE;
			downArrowData.width = 18;
			downArrowData.height = 11;
			textInputData = new GTextInputData();
			textInputData.restrict = "0-9";
			scaleMode = GScaleMode.AUTO_WIDTH;
			width = 120;
			height = 22;
		}

		override public function clone() : * {
			var data : GSpinnerData = new GSpinnerData();
			parse(data);
			return data;
		}
	}
}
