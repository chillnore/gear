package gear.ui.data {
	import flash.display.DisplayObject;
	import gear.ui.core.GBaseData;
	import gear.ui.core.GScaleMode;
	import gear.ui.manager.UIManager;
	import gear.ui.skin.btn.ButtonSkin;


	/**
	 * 选项器控件
	 * 
	 * @author bright
	 * @version 20091215
	 */
	public class GSpinnerData extends GBaseData {
		public var upArrowData : GButtonData;
		public var downArrowData : GButtonData;
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

		public function GSpinnerData() {
			upArrowData = new GButtonData();
			var upSkin : DisplayObject = UIManager.getSkinBy("GSpinner_upArrow_upSkin", "ui");
			var overSkin : DisplayObject = UIManager.getSkinBy("GSpinner_upArrow_overSkin", "ui");
			var downSkin : DisplayObject = UIManager.getSkinBy("GSpinner_upArrow_downSkin", "ui");
			var disabledSkin : DisplayObject = UIManager.getSkinBy("GSpinner_upArrow_disabledSkin", "ui");
			upArrowData.skin = new ButtonSkin(upSkin, overSkin, downSkin, disabledSkin);
			upArrowData.scaleMode = GScaleMode.NONE;
			upArrowData.width = 18;
			upArrowData.height = 11;
			downArrowData = new GButtonData();
			upSkin = UIManager.getSkinBy("GSpinner_downArrow_upSkin", "ui");
			overSkin = UIManager.getSkinBy("GSpinner_downArrow_overSkin", "ui");
			downSkin = UIManager.getSkinBy("GSpinner_downArrow_downSkin", "ui");
			disabledSkin = UIManager.getSkinBy("GSpinner_downArrow_disabledSkin", "ui");
			downArrowData.skin = new ButtonSkin(upSkin, overSkin, downSkin, disabledSkin);
			downArrowData.scaleMode = GScaleMode.NONE;
			downArrowData.width = 18;
			downArrowData.height = 11;
			textInputData = new GTextInputData();
			scaleMode = GScaleMode.AUTO_WIDTH;
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
