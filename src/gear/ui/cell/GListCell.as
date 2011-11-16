package gear.ui.cell {
	import gear.ui.controls.GLabel;
	import gear.ui.layout.GLayout;

	/**
	 * 列表单元格控件
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class GListCell extends GCell {
		protected var _label : GLabel;

		/**
		 * @private
		 * @inheritDoc
		 */
		override protected function create() : void {
			super.create();
			_label = new GLabel(_data.labelData);
			addChild(_label);
		}

		/**
		 * @inheritDoc
		 */
		public function GListCell(data : GCellData) {
			super(data);
		}

		/**
		 * @inheritDoc
		 */
		override public function set source(value : *) : void {
			var data : LabelSource = value as LabelSource;
			if (data == null) {
				_label.clear();
			} else {
				_label.text = data.text;
				GLayout.layout(_label);
			}
			_source = data;
			enabled = (_source != null);
		}
	}
}
