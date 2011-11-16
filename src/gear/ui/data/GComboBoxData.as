package gear.ui.data {
	import gear.net.AssetData;
	import gear.ui.core.GAlign;
	import gear.ui.core.GBaseData;
	import gear.ui.core.ScaleMode;
	import gear.ui.manager.UIManager;
	import gear.ui.skin.button.ButtonSkin;

	import flash.display.Sprite;


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
			var upSkin : Sprite = UIManager.getSkin(new AssetData("GComboBox_upSkin"));
			var overSkin : Sprite = UIManager.getSkin(new AssetData("GComboBox_overSkin"));
			var downSkin : Sprite = UIManager.getSkin(new AssetData("GComboBox_downSkin"));
			var disabledSkin : Sprite = UIManager.getSkin(new AssetData("GComboBox_disabledSkin"));
			buttonData.skin = new ButtonSkin(upSkin, overSkin, downSkin, disabledSkin);
			buttonData.labelData.align = new GAlign(5, -1, -1, -1, -1, 0);
			textInputData = new GTextInputData();
			arrow = new GButtonData();
			upSkin = UIManager.getSkin(new AssetData("GComboBox_arrowUpSkin"));
			overSkin = UIManager.getSkin(new AssetData("GComboBox_arrowOverSkin"));
			downSkin = UIManager.getSkin(new AssetData("GComboBox_arrowDownSkin"));
			disabledSkin = UIManager.getSkin(new AssetData("GComboBox_arrowDisabledSkin"));
			arrow.skin = new ButtonSkin(upSkin, overSkin, downSkin, disabledSkin);
			arrow.width = 18;
			arrow.height = 22;
			listData = new GListData();
			listData.width = 100;
			listData.scaleMode = ScaleMode.AUTO_HEIGHT;
			width = 100;
			height = 22;
		}
	}
}
