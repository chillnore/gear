package gear.key {
	/**
	 * @author Administrator
	 */
	public class KeyData {
		public var keyCode : int;
		public var time : int;

		public function KeyData() {
			reset();
		}

		public function reset() : void {
			keyCode = HotKey.NONE;
			time = 0;
		}
	}
}
