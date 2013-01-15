package gear.gui.group {
	import gear.gui.controls.GToggleBase;
	import gear.log4a.GLogger;

	/**
	 * 双模组
	 * 
	 * @author bright
	 * @version 20130106
	 */
	public class GToggleGroup {
		protected var _selectedIndex : int;
		protected var _list : Vector.<GToggleBase>;
		protected var _enabled : Boolean = true;
		protected var _onChange : Function;

		public function GToggleGroup() {
			_selectedIndex = -1;
			_list = new Vector.<GToggleBase>();
		}

		public function add(value : GToggleBase) : void {
			if (_list.indexOf(value) == -1) {
				_list.push(value);
				value.group = this;
			}
		}

		public function set onChange(value : Function) : void {
			_onChange = value;
		}

		public function set selectedIndex(value : int) : void {
			if (value < 0 || value >= _list.length) {
				return;
			}
			if (_selectedIndex == value) {
				return;
			}
			if (_selectedIndex > -1) {
				_list[_selectedIndex].selected = false;
			}
			_selectedIndex = value;
			_list[_selectedIndex].selected = true;
			if (_onChange != null) {
				try {
					_onChange.apply(null, _onChange.length < 1 ? null : [this]);
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
		}
		
		public function get selectedIndex():int{
			return _selectedIndex;
		}

		public function selected(value : GToggleBase) : void {
			var index : int = _list.indexOf(value);
			selectedIndex = index;
		}

		public function set enabled(value : Boolean) : void {
			if (_enabled == value) {
				return;
			}
			_enabled = value;
			for each (var base:GToggleBase in _list) {
				base.enabled = _enabled;
			}
		}

		public function get enabled() : Boolean {
			return _enabled;
		}
	}
}