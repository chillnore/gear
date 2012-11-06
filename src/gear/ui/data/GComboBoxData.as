package gear.ui.data {
	import flash.display.DisplayObject;
	import gear.ui.core.GAlign;
	import gear.ui.core.GBaseData;
	import gear.ui.core.GScaleMode;
	import gear.ui.manager.GUIUtil;
	import gear.ui.skin.btn.ButtonSkin;


	/**
	 * 组合框控件定义
	 * 
	 * @author bright
	 * @version 20101018
	 */
	public class GComboBoxData extends GBaseData {
		public var buttonData : GButtonData;
		public var textInputData : GTextInputData;
		public var arrow : GButtonData;
		public var listData : GListData;
		public var editable : Boolean = false;

		public function GComboBoxData() {
			buttonData = new GButtonData();
			var upSkin : DisplayObject = GUIUtil.getSkin("GComboBox_upSkin", "ui");
			var overSkin : DisplayObject = GUIUtil.getSkin("GComboBox_overSkin", "ui");
			var downSkin : DisplayObject = GUIUtil.getSkin("GComboBox_downSkin", "ui");
			var disabledSkin : DisplayObject = GUIUtil.getSkin("GComboBox_disabledSkin", "ui");
			buttonData.skin = new ButtonSkin(upSkin, overSkin, downSkin, disabledSkin);
			buttonData.labelData.align = new GAlign(5, -1, -1, -1, -1, 0);
			textInputData = new GTextInputData();
			arrow = new GButtonData();
			upSkin = GUIUtil.getSkin("GComboBox_arrowUpSkin", "ui");
			overSkin = GUIUtil.getSkin("GComboBox_arrowOverSkin", "ui");
			downSkin = GUIUtil.getSkin("GComboBox_arrowDownSkin", "ui");
			disabledSkin = GUIUtil.getSkin("GComboBox_arrowDisabledSkin", "ui");
			arrow.skin = new ButtonSkin(upSkin, overSkin, downSkin, disabledSkin);
			arrow.width = 18;
			arrow.height = 22;
			listData = new GListData();
			listData.width = 100;
			listData.scaleMode = GScaleMode.AUTO_HEIGHT;
			width = 100;
			height = 22;
		}
	}
}
