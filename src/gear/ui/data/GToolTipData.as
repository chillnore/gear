package gear.ui.data {
	import gear.ui.core.GAlignMode;
	import gear.ui.core.GBaseData;
	import gear.ui.core.GScaleMode;
	import gear.ui.manager.GUIUtil;

	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * 提示控件定义
	 * 
	 * @author bright
	 * @version 20101018
	 */
	public class GToolTipData extends GBaseData {
		/**
		 * 背景元件定义
		 */
		public var bgSkin : DisplayObject;
		/**
		 * 标签元件定义
		 */
		public var labelData : GLabelData;
		/**
		 * 边空
		 */
		public var padding : int;
		/**
		 * 对齐模式
		 */
		public var alginMode : int;
		public var alginHGap : int;
		public var alginVGap : int;

		/**
		 * @private
		 */
		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GToolTipData = source as GToolTipData;
			if (data == null) {
				return;
			}
			data.bgSkin = Sprite(GUIUtil.cloneSkin(bgSkin));
			data.labelData = labelData;
			data.padding = padding;
			data.alginMode = alginMode;
			data.alginHGap = alginHGap;
			data.alginVGap = alginVGap;
		}

		public function GToolTipData() {
			bgSkin = GUIUtil.getSkin("GToolTip_bgSkin", "ui");
			labelData = new GLabelData();
			padding = 5;
			alginMode = GAlignMode.BOTTOM_RIGHT;
			alginHGap = alginVGap = 0;
			scaleMode = GScaleMode.AUTO_SIZE;
		}

		override public function clone() : * {
			var data : GToolTipData = new GToolTipData();
			parse(data);
			return data;
		}
	}
}