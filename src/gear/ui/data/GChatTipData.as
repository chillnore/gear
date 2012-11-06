package gear.ui.data {
	import gear.ui.core.GBaseData;
	import gear.ui.core.GScaleMode;
	import gear.ui.manager.GUIUtil;
	import gear.ui.skin.SkinStyle;

	import flash.display.DisplayObject;

	/**
	 * 聊天提示控件定义
	 * 
	 * @author bright
	 * @version 20121105
	 */
	public class GChatTipData extends GBaseData {
		/**
		 * 边框元件定义
		 */
		public var bodySkin : DisplayObject;
		/**
		 * 尾部元件定义
		 */
		public var tailSkin : DisplayObject;
		/**
		 * 标签控件定义
		 */
		public var labelData : GLabelData;
		/**
		 * 间隙
		 */
		public var gap : int;
		/**
		 * 延迟关闭
		 */
		public var timeout : int;

		/**
		 * @private
		 */
		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GChatTipData = source as GChatTipData;
			if (data == null) {
				return;
			}
			data.bodySkin = GUIUtil.cloneSkin(bodySkin);
			data.tailSkin = GUIUtil.cloneSkin(tailSkin);
			data.labelData = (labelData == null ? null : labelData.clone());
		}

		public function GChatTipData() {
			scaleMode = GScaleMode.AUTO_SIZE;
			minWidth = 60;
			minHeight = 30;
			maxWidth = 240;
			maxHeight = 200;
			bodySkin = GUIUtil.getSkin(SkinStyle.chatTip_bodySkin, "ui");
			tailSkin = GUIUtil.getSkin(SkinStyle.chatTip_tailSkin, "ui");
			labelData = new GLabelData();
			labelData.color.upColor = 0x000000;
			labelData.textFieldFilters = GUIUtil.getEdgeFilters(0xFFFFFF, 1);
			labelData.textFieldFilters = null;
			labelData.maxLength = 48;
			gap = 7;
			timeout = 10;
		}

		/**
		 * @inheritDoc
		 */
		override public function clone() : * {
			var data : GChatTipData = new GChatTipData();
			parse(data);
			return data;
		}
	}
}
