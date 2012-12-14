package gear.gui.group {
	import gear.gui.controls.GToggleBase;

	/**
	 * 双模组
	 * 
	 * @author bright
	 * @version 20121204
	 */
	public class GToggleGroup {
		protected var _selectedIndex:int;
		protected var _list:Vector.<GToggleBase>;
		protected var _enabled : Boolean = true;

		public function GToggleGroup() {
			_selectedIndex=-1;
			_list=new Vector.<GToggleBase>();
		}
		
		public function selected(value:GToggleBase):void{
		}

		public function set enabled(value : Boolean) : void {
			if (_enabled == value){
				return;
			}
			_enabled = value;
			for each(var base:GToggleBase in _list){
				base.enabled = _enabled;
			}
		}

		public function get enabled() : Boolean {
			return _enabled;
		}
	}
}