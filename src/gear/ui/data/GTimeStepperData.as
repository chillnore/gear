package gear.ui.data {
	import gear.net.AssetData;
	import gear.ui.core.GBaseData;

	/**
	 * Game Time Stepper Data
	 * 
	 * @author BrightLi
	 * @version 20100608
	 */
	public class GTimeStepperData extends GBaseData {
		public var bdAsset : AssetData;
		public var limit : int;

		public function GTimeStepperData() {
			bdAsset = new AssetData("time_number");
			limit = 60;
		}
	}
}
