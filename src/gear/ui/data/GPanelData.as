package gear.ui.data {
	import gear.log4a.LogError;
	import gear.net.AssetData;
	import gear.ui.core.GBaseData;
	import gear.ui.manager.UIManager;
	import gear.ui.skin.SkinStyle;

	import flash.display.Sprite;


	/**
	 * GPanelData 面板控件定义
	 * 
	 * @author bright
	 * @version 20110221
	 */
	public class GPanelData extends GBaseData {
		public var bgSkin : Sprite;
		public var modal : Boolean = false;
		public var padding : int = 0;
		public var scrollBarData : GScrollBarData = new GScrollBarData();

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GPanelData = source as GPanelData;
			if (data == null) {
				return;
			}
			data.bgSkin = UIManager.cloneSkin(bgSkin) as Sprite;
			data.modal = modal;
			data.padding = padding;
			data.scrollBarData = scrollBarData.clone();
		}

		public function GPanelData() {
			bgSkin = UIManager.getSkin(new AssetData(SkinStyle.panel_bgSkin));
			width = 100;
			height = 100;
		}

		public function bindTo(value : Sprite) : void {
			if (value == null) {
				throw new LogError("bind target is null!");
			}
			bgSkin = value;
			x = Math.round(bgSkin.x);
			y = Math.round(bgSkin.y);
			bgSkin.x = 0;
			bgSkin.y = 0;
			bgSkin.mouseEnabled = false;
			bgSkin.mouseChildren = true;
		}

		override public function clone() : * {
			var data : GPanelData = new GPanelData();
			parse(data);
			return data;
		}
	}
}
