package gear.ui.data {
	import gear.ui.core.GBaseData;
	import gear.ui.manager.GUIUtil;
	import gear.ui.skin.SkinStyle;

	import flash.display.DisplayObject;

	/**
	 * GPanelData 面板控件定义
	 * 
	 * @author bright
	 * @version 20110221
	 */
	public class GPanelData extends GBaseData {
		public var bgSkin : DisplayObject;
		public var modal : Boolean = false;
		public var padding : int = 0;
		public var scrollBarData : GScrollBarData = new GScrollBarData();

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GPanelData = source as GPanelData;
			if (data == null) {
				return;
			}
			data.bgSkin = GUIUtil.cloneSkin(bgSkin);
			data.modal = modal;
			data.padding = padding;
			data.scrollBarData = scrollBarData.clone();
		}

		public function GPanelData() {
			bgSkin = GUIUtil.getSkin(SkinStyle.panel_bgSkin, "ui");
			width = 100;
			height = 100;
		}

		override public function clone() : * {
			var data : GPanelData = new GPanelData();
			parse(data);
			return data;
		}
	}
}
