package gear.ui.data {
	import gear.ui.core.GBaseData;
	import gear.ui.manager.UIManager;
	import gear.ui.skin.SkinStyle;

	import flash.display.DisplayObject;

	/**
	 * 复选框控件定义
	 * 
	 * @author bright
	 * @version 20120814
	 */
	public class GCheckBoxData extends GBaseData {
		/**
		 * 鼠标抬起元件定义
		 */
		public var upSkin : DisplayObject;
		/**
		 * 示选中图标控件定义
		 */
		public var upIcon : DisplayObject;
		/**
		 * 选中图标控件定义
		 */
		public var selectedUpIcon : DisplayObject;
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
			data.upSkin = UIManager.cloneSkin(upSkin);
			data.upIcon = upIcon;
			data.selectedUpIcon = selectedUpIcon;
			data.labelData = labelData.clone();
			data.selected = selected;
			data.hGap = hGap;
			data.padding = padding;
		}

		public function GCheckBoxData() {
			upSkin = UIManager.getSkinBy(SkinStyle.emptySkin, "ui");
			upIcon = UIManager.getSkinBy(SkinStyle.checkBox_upIcon, "ui");
			selectedUpIcon = UIManager.getSkinBy(SkinStyle.checkBox_selectedUpIcon, "ui");
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
