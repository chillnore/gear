package gear.ui.data {
	import gear.ui.core.GBaseData;
	import gear.ui.manager.GUIUtil;
	import gear.ui.skin.SkinStyle;
	import gear.utils.GBDUtil;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;

	/**
	 * 复选框控件定义
	 * 
	 * @author bright
	 * @version 20121105
	 */
	public class GCheckBoxData extends GBaseData {
		/**
		 * 鼠标抬起元件定义
		 */
		public var upSkin : DisplayObject;
		/**
		 * 示选中图标控件定义
		 */
		public var upIcon : BitmapData;
		/**
		 * 选中图标控件定义
		 */
		public var selectedUpIcon:BitmapData;
		/**
		 * 标签控件定义
		 * @see gear.ui.data.GLabelData
		 */
		public var labelData : GLabelData;
		/**
		 * 是否选中
		 */
		public var selected : Boolean ;
		/**
		 * 边空
		 */
		public var padding : int;
		/**
		 * 水平间隙
		 */
		public var hGap : int;

		/**
		 * @private
		 */
		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GCheckBoxData = source as GCheckBoxData;
			if (data == null) {
				return;
			}
			data.upSkin = GUIUtil.cloneSkin(upSkin);
			data.upIcon = upIcon;
			data.selectedUpIcon = selectedUpIcon;
			data.labelData = labelData.clone();
			data.selected = selected;
			data.hGap = hGap;
			data.padding = padding;
		}

		public function GCheckBoxData() {
			upSkin = GUIUtil.getSkin(SkinStyle.emptySkin, "ui");
			upIcon = GBDUtil.getBDBy(SkinStyle.checkBox_upIcon, "ui");
			selectedUpIcon = GBDUtil.getBDBy(SkinStyle.checkBox_selectedUpIcon, "ui");
			labelData = new GLabelData();
			labelData.text = "Label";
			selected = false;
			padding = 2;
			hGap = 3;
			width = 70;
			height = 18;
		}

		/**
		 * @inheritDoc
		 */
		override public function clone() : * {
			var data : GCheckBoxData = new GCheckBoxData();
			parse(data);
			return data;
		}
	}
}
