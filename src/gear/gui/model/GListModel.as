package gear.gui.model {
	import gear.log4a.GLogger;

	/**
	 * 列表模型
	 * 
	 * @author bright
	 * @version 20130415
	 */
	public class GListModel {
		protected var _source : Vector.<Object>;
		protected var _change : Vector.<Function>;

		protected function change(value : GListChange) : void {
			for each (var change : Function in _change) {
				try {
					change.apply(null, [value]);
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
		}

		public function GListModel() {
			_source = new Vector.<Object>();
			_change = new Vector.<Function>();
		}

		public function get length() : int {
			return _source.length;
		}

		public function add(value : *) : void {
			var index : int = _source.push(value) - 1;
			change(new GListChange(GListChange.ADDED, index));
		}

		public function addAt(index : int, value : *) : void {
			if (index < 0) {
				return;
			}
			if (index == 0) {
				_source.unshift(value);
			} else {
				_source.splice(index, 0, value);
			}
			change(new GListChange(GListChange.ADDED, index));
		}

		public function remove(value : *) : void {
			removeAt(_source.indexOf(value));
		}

		public function removeAt(index : int) : void {
			if (index < 0 || index >= _source.length) {
				return;
			}
			_source.splice(index, 1);
			change(new GListChange(GListChange.REMOVED, index));
		}

		public function setAt(index : int, value : *) : void {
			if ( index < 0 || index >= _source.length) {
				return;
			}
			_source[index] = value;
			change(new GListChange(GListChange.UPDATE, index));
		}

		public function getAt(value : int) : * {
			if (value < 0 || value >= _source.length) {
				return null;
			}
			return _source[value];
		}

		public function findBy(key : String, value : *) : int {
			var index : int = 0;
			for each (var item : Object in _source) {
				if (!item.hasOwnProperty(key)) {
					return -1;
				}
				if (item[key] == value) {
					return index;
				}
				index++;
			}
			return -1;
		}

		public function update(index : int) : void {
			if ( index < 0 || index >= _source.length) {
				return;
			}
			change(new GListChange(GListChange.UPDATE, index));
		}

		public function clear() : void {
			_source.length = 0;
			change(new GListChange(GListChange.RESET));
		}

		public function set onChange(value : Function) : void {
			if (_change.indexOf(value) == -1) {
				_change.push(value);
			}
		}

		public function removeOnChange(value : Function) : void {
			var index : int = _change.indexOf(value);
			if (index != -1) {
				_change.splice(index, 1);
			}
		}

		public function set source(value : Object) : void {
			_source = Vector.<Object>(value);
			change(new GListChange(GListChange.RESET));
		}
	}
}
