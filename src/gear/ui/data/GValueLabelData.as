package gear.ui.data {
	import gear.ui.core.GBaseData;

	/**
	 * @author suijiabin
	 */
	public class GValueLabelData extends GBaseData {
		public var nameLableData : GLabelData;
		public var valueLableData : GLabelData;

		public function GValueLabelData() {
			nameLableData = new GLabelData();
			valueLableData =  new GLabelData();
			super();
		}

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GValueLabelData = source as GValueLabelData;
			data.nameLableData = nameLableData.clone();
			data.valueLableData = valueLableData.clone();
		}

		override public function clone() : * {
			var data : GValueLabelData = new GValueLabelData();
			parse(data);
			return data;
		}
	}
}
