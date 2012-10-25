package gear.ui.data {
	import gear.ui.core.GAlign;
	import gear.ui.core.GBaseData;

	import flash.display.Sprite;


	/**
	 * 翻页控制控件定义
	 * 
	 * @author bright
	 * @version 20101011
	 */
	public class GPageControlData extends GBaseData {
		public var bgSkin : Sprite;
		/**
		 * 上一页按钮控件定义
		 */
		public var prev_buttonData : GButtonData;
		/**
		 * 下一页按钮控件定义
		 */
		public var next_buttonData : GButtonData;
		/**
		 * 分页标签控件定义
		 */
		public var labelData : GLabelData;

		/**
		 * @private
		 */
		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GPageControlData = source as GPageControlData;
			if (data == null) {
				return;
			}
			data.prev_buttonData = (prev_buttonData == null ? null : prev_buttonData.clone());
			data.next_buttonData = (next_buttonData == null ? null : next_buttonData.clone());
			data.labelData = (labelData == null ? null : labelData.clone());
		}

		public function GPageControlData() {
			width = 150;
			height = 24;
			prev_buttonData = new GButtonData();
			prev_buttonData.width = 50;
			prev_buttonData.align = new GAlign(0, -1, -1, -1, -1, 0);
			prev_buttonData.labelData.text = "prev";
			next_buttonData = new GButtonData();
			next_buttonData.width = 50;
			next_buttonData.align = new GAlign(-1, 0, -1, -1, -1, 0);
			next_buttonData.labelData.text = "next";
			labelData = new GLabelData();
			labelData.align = GAlign.CENTER;
			labelData.text = "1/1";
		}

		/**
		 * @inheritDoc
		 */
		override public function clone() : * {
			var data : GPageControlData = new GPageControlData();
			parse(data);
			return data;
		}
	}
}