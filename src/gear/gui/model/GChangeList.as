package gear.gui.model {
	/**
	 * @author bright
	 */
	public class GChangeList {
		protected var _list : Vector.<GChange>;

		public function GChangeList() {
			_list=new Vector.<GChange>();
		}

		public function add(value : GChange) : void {
			if (value.state == GChange.RESET) {
				_list.length = 0;
			}
			_list.push(value);
		}
		
		public function get hasNext():Boolean{
			return _list.length>0;
		}
		
		public function shift():GChange{
			return _list.shift();
		}
	}
}
