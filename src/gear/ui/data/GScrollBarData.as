package gear.ui.data {
	import gear.net.AssetData;
	import gear.ui.core.GBaseData;
	import gear.ui.manager.UIManager;
	import gear.ui.skin.SkinStyle;
	import gear.ui.skin.button.ButtonSkin;

	import flash.display.Sprite;


	/**
	 * @version 20091215
	 * @author bright
	 */
	public class GScrollBarData extends GBaseData {
		public static const VERTICAL : int = 0;
		public static const HORIZONTAL : int = 1;
		public var trackAsset : AssetData = new AssetData(SkinStyle.scrollBar_trackSkin);
		public var thumbButtonData : GButtonData;
		public var direction : int = VERTICAL;
		public var wheelSpeed : int = 2;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GScrollBarData = source as GScrollBarData;
			if (data == null) {
				return;
			}
			data.trackAsset = trackAsset;
			data.thumbButtonData = (thumbButtonData ? thumbButtonData.clone() : null);
			data.direction = direction;
			data.wheelSpeed = wheelSpeed;
		}

		public function GScrollBarData() {
			thumbButtonData = new GButtonData();
			var upSkin : Sprite = UIManager.getSkin(new AssetData(SkinStyle.scrollBar_thumbUpSkin));
			var overSkin : Sprite = UIManager.getSkin(new AssetData(SkinStyle.scrollBar_thumbOverSkin));
			var downSkin : Sprite = UIManager.getSkin(new AssetData(SkinStyle.scrollBar_thumbDownSkin));
			var disabledSkin : Sprite = null;
			thumbButtonData.skin = new ButtonSkin(upSkin, overSkin, downSkin, disabledSkin);
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
