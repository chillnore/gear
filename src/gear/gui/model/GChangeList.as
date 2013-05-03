package gear.gui.model {
	/**
	 * @author bright
	 */
	public class GChangeList {
		protected var _list : Vector.<GListChange>;

		public function GChangeList() {
			_list=new Vector.<GListChange>();
		}

		public function add(value : GListChange) : void {
			if (value.state == GListChange.RESET) {
				_list.length = 0;
			}
			_list.push(value);
		}
		
		public function get hasNext():Boolean{
			return _list.length>0;
		}
		
		public function shift():GListChange{
			return _list.shift();
		}
	}
}
