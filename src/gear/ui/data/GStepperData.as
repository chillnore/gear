package gear.ui.data {
	import gear.net.AssetData;
	import gear.ui.core.GBaseData;
	import gear.ui.core.ScaleMode;
	import gear.ui.manager.UIManager;
	import gear.ui.skin.button.ButtonSkin;

	import flash.display.Sprite;

	/**
	 * GStepper 步进器控件定义
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class GStepperData extends GBaseData {
		// 向上按钮定义
		public var upArrowData : GButtonData;
		// 向下按钮定义
		public var downArrowData : GButtonData;
		// 输入框定义
		public var textInputData : GTextInputData;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GSpinnerData = source as GSpinnerData;
			if (data == null)
				return;
			data.upArrowData = (upArrowData ? upArrowData.clone() : null);
			data.downArrowData = (downArrowData ? downArrowData.clone() : null);
			data.textInputData = (textInputData ? textInputData.clone() : null);
		}

		public function GStepperData() {
			upArrowData = new GButtonData();
			var upSkin : Sprite = UIManager.getSkin(new AssetData("GSpinner_upArrow_upSkin"));
			var overSkin : Sprite = UIManager.getSkin(new AssetData("GSpinner_upArrow_overSkin"));
			var downSkin : Sprite = UIManager.getSkin(new AssetData("GSpinner_upArrow_downSkin"));
			var disabledSkin : Sprite = UIManager.getSkin(new AssetData("GSpinner_upArrow_disabledSkin"));
			upArrowData.skin = new ButtonSkin(upSkin, overSkin, downSkin, disabledSkin);
			upArrowData.scaleMode = ScaleMode.NONE;
			upArrowData.width = 18;
			upArrowData.height = 11;
			downArrowData = new GButtonData();
			upSkin = UIManager.getSkin(new AssetData("GSpinner_downArrow_upSkin"));
			overSkin = UIManager.getSkin(new AssetData("GSpinner_downArrow_overSkin"));
			downSkin = UIManager.getSkin(new AssetData("GSpinner_downArrow_downSkin"));
			disabledSkin = UIManager.getSkin(new AssetData("GSpinner_downArrow_disabledSkin"));
			downArrowData.skin = new ButtonSkin(upSkin, overSkin, downSkin, disabledSkin);
			downArrowData.scaleMode = ScaleMode.NONE;
			downArrowData.width = 18;
			downArrowData.height = 11;
			textInputData = new GTextInputData();
			textInputData.restrict = "0-9";
			scaleMode = ScaleMode.AUTO_WIDTH;
			width = 70;
			height = 22;
		}

		override public function clone() : * {
			var data : GSpinnerData = new GSpinnerData();
			parse(data);
			return data;
		}
	}
}
