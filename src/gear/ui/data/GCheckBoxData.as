package gear.ui.data {
	import gear.net.AssetData;
	import gear.ui.core.GBaseData;
	import gear.ui.skin.SkinStyle;
	/**
	 * 复选框控件定义
	 * 
	 * @author bright
	 * @version 20101018
	 */
	public class GCheckBoxData extends GBaseData {
		/**
		 * 鼠标抬起元件定义
		 */
		public var upAsset : AssetData;
		/**
		 * 示选中图标控件定义
		 */
		public var upIcon : AssetData;
		/**
		 * 选中图标控件定义
		 */
		public var selectedUpIcon : AssetData;
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
			if(data == null) {
				return;
			}
			data.upAsset = upAsset;
			data.upIcon = upIcon;
			data.selectedUpIcon = selectedUpIcon;
			data.labelData = labelData.clone();
			data.selected = selected;
			data.hGap = hGap;
			data.padding = padding;
		}

		public function GCheckBoxData() {
			upAsset = new AssetData(SkinStyle.emptySkin, AssetData.AS_LIB);
			upIcon = new AssetData(SkinStyle.checkBox_upIcon);
			selectedUpIcon = new AssetData(SkinStyle.checkBox_selectedUpIcon);
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
