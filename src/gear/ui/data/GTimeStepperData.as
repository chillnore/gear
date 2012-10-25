package gear.ui.data {
	import gear.ui.core.GBaseData;

	/**
	 * Game Time Stepper Data
	 * 
	 * @author BrightLi
	 * @version 20100608
	 */
	public class GTimeStepperData extends GBaseData {
		public var bdKey : String;
		public var bdLib : String;
		public var limit : int;

		public function GTimeStepperData() {
			bdKey = "time_number";
			bdLib = "ui.swf";
			limit = 60;
		}
	}
}
