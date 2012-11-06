package gear.ui.data {
	import gear.ui.cell.GCell;
	import gear.ui.cell.GCellData;
	import gear.ui.controls.GAlert;
	import gear.ui.core.GScaleMode;
	import gear.ui.manager.GUIUtil;
	import gear.utils.GBDUtil;

	/**
	 * 格子控件定义
	 * 
	 * @author bright
	 * @version 20101018
	 */
	public class GGridData extends GPanelData {
		/**
		 * 允许拖动
		 */
		public var allowDrag : Boolean = false;
		/**
		 * 水平间隙
		 */
		public var hgap : int = 2;
		/**
		 * 垂直间隙
		 */
		public var vgap : int = 2;
		/**
		 * 列数
		 */
		public var columns : int = 3;
		/**
		 * 行数
		 */
		public var rows : int = 3;
		/**
		 * 单元格控件模板类
		 */
		public var cell : Class = GCell;
		/**
		 * 单元格控件定义
		 */
		public var cellData : GCellData = new GCellData();
		/**
		 * 对话框控件定义
		 */
		public var alertData : GAlertData;
		/**
		 * 热键数组
		 */
		public var hotKeys : Array;

		/**
		 * @private
		 */
		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GGridData = source as GGridData;
			if (data == null) {
				return;
			}
			data.allowDrag = allowDrag;
			data.hgap = hgap;
			data.vgap = vgap;
			data.columns = columns;
			data.rows = rows;
			data.cell = cell;
			data.cellData = cellData.clone();
			data.alertData = alertData.clone();
		}

		public function GGridData() {
			alertData = new GAlertData();
			alertData.parent = GUIUtil.root;
			alertData.labelData.iconData.bitmapData = GBDUtil.getBDBy("light_22", "uiLib");
			alertData.flag = GAlert.YES | GAlert.NO;
			scaleMode = GScaleMode.AUTO_SIZE;
		}

		/**
		 * @inheritDoc
		 */
		override public function clone() : * {
			var data : GGridData = new GGridData();
			parse(data);
			return data;
		}
	}
}
