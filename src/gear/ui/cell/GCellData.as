package gear.ui.cell {
	import gear.log4a.GLogError;
	import gear.ui.core.GAlign;
	import gear.ui.core.GBaseData;
	import gear.ui.core.GScaleMode;
	import gear.ui.data.GIconData;
	import gear.ui.data.GLabelData;
	import gear.ui.manager.GUIUtil;
	import gear.ui.skin.SkinStyle;
	import gear.ui.skin.tb.IToggleButtonSkin;
	import gear.ui.skin.tb.MCToggleButtonSkin;
	import gear.ui.skin.tb.ToggleButtonSkin;
	import gear.utils.GBDUtil;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * 单元格控件定义
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class GCellData extends GBaseData {
		/**
		 * 皮肤
		 */
		public var skin : IToggleButtonSkin;
		/**
		 * 锁图标控件定义
		 */
		public var lockIconData : GIconData;
		/**
		 * 标签控件定义
		 */
		public var labelData : GLabelData;
		/**
		 * 是否允许选择
		 */
		public var allowSelect : Boolean ;
		/**
		 * 是否允许双击
		 */
		public var allowDoubleClick : Boolean;
		/**
		 * 是否上锁
		 */
		public var lock : Boolean;
		/**
		 * 热键显示
		 */
		public var hotKey : String;

		/**
		 * @private
		 */
		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GCellData = source as GCellData;
			if (data == null) {
				return;
			}
			data.skin = (skin != null ? skin.clone() : null);
			data.lockIconData = (lockIconData != null ? data.lockIconData.clone() : null);
			data.labelData = labelData.clone();
			data.allowSelect = allowSelect;
			data.allowDoubleClick = allowDoubleClick;
			data.lock = lock;
		}

		/**
		 * 构造函数
		 */
		public function GCellData() {
			var upSkin : DisplayObject = GUIUtil.getSkin(SkinStyle.cell_upSkin, "ui");
			var overSkin : DisplayObject = GUIUtil.getSkin(SkinStyle.cell_overSkin, "ui");
			var downSkin : DisplayObject = GUIUtil.getSkin(SkinStyle.cell_downSkin, "ui");
			var disabledSkin : DisplayObject = GUIUtil.getSkin(SkinStyle.cell_disabledSkin, "ui");
			var selectedUpSkin : DisplayObject = GUIUtil.getSkin(SkinStyle.cell_selectedUpSkin, "ui");
			var selectedOverSkin : DisplayObject = GUIUtil.getSkin(SkinStyle.cell_selectedOverSkin, "ui");
			var selectedDownSkin : DisplayObject = GUIUtil.getSkin(SkinStyle.cell_selectedDownSkin, "ui");
			var selectedDisabledSkin : DisplayObject = GUIUtil.getSkin(SkinStyle.cell_selectedDisabledSkin, "ui");
			skin = new ToggleButtonSkin(upSkin, overSkin, downSkin, disabledSkin, selectedUpSkin, selectedOverSkin, selectedDownSkin, selectedDisabledSkin);
			lockIconData = new GIconData();
			labelData = new GLabelData();
			allowSelect = true;
			allowDoubleClick = false;
			lock = false;
			width = 80;
			height = 22;
			labelData.align = new GAlign(8, -1, -1, -1, -1, 0);
			lockIconData.bitmapData = GBDUtil.getBDBy("lock_icon", "uiLib");
			lockIconData.align = GAlign.CENTER;
		}

		public function bindTo(mc : MovieClip) : void {
			if (mc == null) {
				throw new GLogError("GCellData.bindTo:mc is null!");
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
			scaleMode = GScaleMode.NONE;
		}

		/**
		 * 克隆
		 * 
		 * @return 单元格控件定义
		 */
		override public function clone() : * {
			var data : GCellData = new GCellData();
			parse(data);
			return data;
		}
	}
}
