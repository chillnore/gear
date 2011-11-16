package gear.ui.data {
	import gear.ui.cell.GCellData;
	import gear.ui.cell.GListCell;
	/**
	 * 列表控件定义
	 * 
	 * @author bright
	 * @version 20101018
	 */
	public class GListData extends GPanelData {
		/**
		 * 水平间隙
		 */
		public var hGap : int;
		/**
		 * 行数
		 */
		public var rows : int;
		/**
		 * 单元格模板类
		 */
		public var cell : Class;
		/**
		 * 单元格控件定义
		 */
		public var cellData : GCellData;

		/**
		 * @private
		 */
		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GListData = source as GListData;
			if(data == null) {
				return;
			}
			data.hGap = hGap;
			data.rows = rows;
			data.cell = cell;
			data.cellData = cellData.clone();
		}

		public function GListData() {
			padding = 2;
			hGap = 1;
			rows = 5;
			cell = GListCell;
			cellData = new GCellData();
		}

		/**
		 * @inheritDoc
		 */
		override public function clone() : * {
			var data : GListData = new GListData();
			parse(data);
			return data;
		}
	}
}
