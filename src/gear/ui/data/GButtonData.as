package gear.ui.data {
	import flash.display.DisplayObject;
	import gear.ui.core.GAlign;
	import gear.ui.core.GBaseData;
	import gear.ui.manager.GUIUtil;
	import gear.ui.skin.SkinStyle;
	import gear.ui.skin.btn.ButtonSkin;
	import gear.ui.skin.btn.IButtonSkin;


	/**
	 * 按钮控件定义
	 * 
	 * @author bright
	 * @version 20121105
	 */
	public class GButtonData extends GBaseData {
		public var skin : IButtonSkin;
		/**
		 * 标签控件定义
		 */
		public var labelData : GLabelData;
		/**
		 * 边空
		 */
		public var padding : int;

		/**
		 * @private
		 */
		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GButtonData = source as GButtonData;
			if (data == null) {
				return;
			}
			data.skin = (skin != null ? skin.clone() : null);
			data.labelData = (labelData ? labelData.clone() : null);
		}
		
		/**
		 * 按钮控件定义
		 */
		public function GButtonData() {
			width = 70;
			height = 24;
			var upSkin : DisplayObject = GUIUtil.getSkin(SkinStyle.button_upSkin, "ui");
			var overSkin : DisplayObject = GUIUtil.getSkin(SkinStyle.button_overSkin, "ui");
			var downSkin : DisplayObject = GUIUtil.getSkin(SkinStyle.button_downSkin, "ui");
			var disabledSkin : DisplayObject = GUIUtil.getSkin(SkinStyle.button_disabledSkin, "ui");
			skin = new ButtonSkin(upSkin, overSkin, downSkin, disabledSkin);
			labelData = new GLabelData();
			labelData.align = new GAlign(-1, -1, -1, -1, 0, 0);
			labelData.color.overColor = 0xFFFFFF;
			labelData.color.disabledColor = 0x898989;
			padding = 3;
		}

		/**
		 * @inheritDoc
		 */
		override public function clone() : * {
			var data : GButtonData = new GButtonData();
			parse(data);
			return data;
		}
	}
}
