package gear.ui.data {
	import gear.net.AssetData;
	import gear.ui.core.GBaseData;
	import gear.ui.core.ScaleMode;
	import gear.ui.manager.UIManager;
	import gear.ui.skin.SkinStyle;

	/**
	 * 聊天提示控件定义
	 * 
	 * @author bright
	 * @version 20101018
	 */
	public class GChatTipData extends GBaseData {
		/**
		 * 边框元件定义
		 */
		public var bodyAsset : AssetData;
		/**
		 * 尾部元件定义
		 */
		public var tailAsset : AssetData;
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
			if (data == null)
				return;
			data.bodyAsset = bodyAsset;
			data.tailAsset = tailAsset;
			data.labelData = (labelData == null ? null : labelData.clone());
		}

		public function GChatTipData() {
			scaleMode = ScaleMode.AUTO_SIZE;
			minWidth = 60;
			minHeight = 30;
			maxWidth = 240;
			maxHeight = 200;
			bodyAsset = new AssetData(SkinStyle.chatTip_bodySkin);
			tailAsset = new AssetData(SkinStyle.chatTip_tailSkin);
			labelData = new GLabelData();
			labelData.color.upColor = 0x000000;
			labelData.textFieldFilters = UIManager.getEdgeFilters(0xFFFFFF, 1);
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
