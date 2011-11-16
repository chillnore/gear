package gear.ui.data {
	import gear.log4a.LogError;
	import gear.net.AssetData;
	import gear.ui.core.GAlign;
	import gear.ui.core.GBaseData;
	import gear.ui.core.ScaleMode;
	import gear.ui.manager.UIManager;
	import gear.ui.skin.SkinStyle;
	import gear.ui.skin.tb.IToggleButtonSkin;
	import gear.ui.skin.tb.MCToggleButtonSkin;
	import gear.ui.skin.tb.ToggleButtonSkin;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;


	/**
	 * GToggleButtonData 双模控件定义
	 * 
	 * @author bright
	 * @verison 20101012
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
			var upSkin : Sprite = UIManager.getSkin(new AssetData(SkinStyle.button_upSkin));
			var overSkin : Sprite = UIManager.getSkin(new AssetData(SkinStyle.button_overSkin));
			var downSkin : Sprite = UIManager.getSkin(new AssetData(SkinStyle.button_downSkin));
			var disabledSkin : Sprite = UIManager.getSkin(new AssetData(SkinStyle.button_disabledSkin));
			var selectedUpSkin : Sprite = UIManager.getSkin(new AssetData(SkinStyle.button_selectedUpSkin));
			var selectedOverSkin : Sprite = UIManager.getSkin(new AssetData(SkinStyle.button_selectedOverSkin));
			var selectedDownSkin : Sprite = UIManager.getSkin(new AssetData(SkinStyle.button_selectedDownSkin));
			var selectedDisabledSkin : Sprite = UIManager.getSkin(new AssetData(SkinStyle.button_selectedDisabledSkin));
			skin = new ToggleButtonSkin(upSkin, overSkin, downSkin, disabledSkin, selectedUpSkin, selectedOverSkin, selectedDownSkin, selectedDisabledSkin);
			width = 70;
			height = 24;
			labelData = new GLabelData();
			labelData.align = GAlign.CENTER;
		}

		/**
		 * 绑定MovieClip到双模按钮控件皮肤
		 * 
		 * @param mc MovieClip
		 */
		public function bindTo(mc : MovieClip) : void {
			if (mc == null) {
				throw new LogError("GToggleButtonData.bindTo:mc is null!");
			}
			mc.gotoAndStop(1);
			x = Math.round(mc.x);
			y = Math.round(mc.y);
			mc.x = 0;
			mc.y = 0;
			var label : TextField = mc.getChildByName("label") as TextField;
			if (label != null) {
				labelData.bindTo(label);
				mc.addFrameScript(0, function() : void {
					var tf : TextField = mc.getChildByName("label") as TextField;
					if (tf != null) {
						tf.parent.removeChild(tf);
					}
				});
			}
			skin = new MCToggleButtonSkin(mc);
			scaleMode = ScaleMode.NONE;
		}

		override public function clone() : * {
			var data : GToggleButtonData = new GToggleButtonData();
			parse(data);
			return data;
		}
	}
}
