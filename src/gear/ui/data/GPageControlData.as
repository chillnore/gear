package gear.ui.data {
	import gear.log4a.LogError;
	import gear.ui.core.GAlign;
	import gear.ui.core.GBaseData;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;


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

		public function bindTo(value : Sprite) : void {
			if (value == null) {
				throw new LogError("bind target is null");
			}
			x = Math.round(value.x);
			y = Math.round(value.y);
			value.x = 0;
			value.y = 0;
			var prevSkin : MovieClip = value.getChildByName("prev_btn") as MovieClip;
			if (prevSkin == null) {
				throw new LogError("must has prev_btn");
			}
			var nextSkin : MovieClip = value.getChildByName("next_btn") as MovieClip;
			if (nextSkin == null) {
				throw new LogError("must has next_btn");
			}
			var label : TextField = value.getChildByName("label") as TextField;
			if (label == null) {
				throw new LogError("must has label");
			}
			bgSkin = value.getChildByName("bg") as Sprite;
			width = bgSkin.width;
			height = bgSkin.height;
			prev_buttonData.bindTo(prevSkin);
			prev_buttonData.labelData.text = "";
			next_buttonData.bindTo(nextSkin);
			next_buttonData.labelData.text = "";
			labelData.bindTo(label);
			labelData.align = null;
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