package gear.ui.data {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import gear.ui.core.GBaseData;
	import gear.ui.manager.GUIUtil;
	import gear.ui.skin.SkinStyle;
	import gear.ui.skin.btn.ButtonSkin;


	/**
	 * 滚动条控件定义
	 * 
	 * @author bright
	 * @version 20121105
	 */
	public class GScrollBarData extends GBaseData {
		public static const VERTICAL : int = 0;
		public static const HORIZONTAL : int = 1;
		public var trackSkin : DisplayObject;
		public var thumbButtonData : GButtonData;
		public var upButtonData : GButtonData;
		public var downButtonData : GButtonData;
		public var direction : int = VERTICAL;
		public var wheelSpeed : int = 2;
		public var padding : int = 0;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GScrollBarData = source as GScrollBarData;
			if (data == null) {
				return;
			}
			data.trackSkin = GUIUtil.cloneSkin(trackSkin);
			data.thumbButtonData = (thumbButtonData ? thumbButtonData.clone() : null);
			data.direction = direction;
			data.wheelSpeed = wheelSpeed;
			data.downButtonData = (downButtonData ? downButtonData.clone() : null);
			data.upButtonData = (upButtonData ? upButtonData.clone() : null);
			data.padding = padding;
		}

		public function GScrollBarData() {
			thumbButtonData = new GButtonData();
			var upSkin : DisplayObject = GUIUtil.getSkinBy(SkinStyle.scrollBar_thumbUpSkin,"ui");
			var overSkin : DisplayObject = GUIUtil.getSkinBy(SkinStyle.scrollBar_thumbOverSkin,"ui");
			var downSkin : DisplayObject = GUIUtil.getSkinBy(SkinStyle.scrollBar_thumbDownSkin,"ui");
			var disabledSkin : Sprite = null;
			thumbButtonData.skin = new ButtonSkin(upSkin, overSkin, downSkin, disabledSkin);
			//TODO
			/*
			upButtonData = new GButtonData();
			upSkin = UIManager.getSkinBy(new AssetData("beibao_icon_shang_001"));
			overSkin = UIManager.getSkinBy(new AssetData("beibao_icon_shang_002"));
			downSkin = UIManager.getSkinBy(new AssetData("beibao_icon_shang_003"));
			disabledSkin = null;
			upButtonData.skin = new ButtonSkin(upSkin, overSkin, downSkin, disabledSkin);
			upButtonData.x = -5;
			upButtonData.width = 23;
			upButtonData.height = 23;

			downButtonData = new GButtonData();
			upSkin = UIManager.getSkin(new AssetData("beibao_icon_xia_001"));
			overSkin = UIManager.getSkin(new AssetData("beibao_icon_xia_002"));
			downSkin = UIManager.getSkin(new AssetData("beibao_icon_xia_003"));
			disabledSkin = null;
			downButtonData.skin = new ButtonSkin(upSkin, overSkin, downSkin, disabledSkin);
			downButtonData.width = 23;
			downButtonData.height = 23;
			downButtonData.x = -5;
			 */
			width = 14;
			height = 100;
		}

		override public function clone() : * {
			var data : GScrollBarData = new GScrollBarData();
			parse(data);
			return data;
		}
	}
}
