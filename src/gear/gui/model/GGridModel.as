package gear.gui.model {
	import gear.log4a.GLogger;

	/**
	 * @author bright
	 */
	public class GGridModel {
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

		protected function resetLength() : void {
			var index : int = _source.length;
			while (index-- > -1) {
				if (_source[index] == null) {
					_source.length = index;
				} else {
					break;
				}
			}
		}

		public function GGridModel() {
			_source = new Vector.<Object>();
			_change = new Vector.<Function>();
		}

		public function set onChange(value : Function) : void {
			if (_change.indexOf(value) == -1) {
				_change.push(value);
			}
		}

		public function setAt(index : int, value : *) : void {
			if ( index < 0 ) {
				return;
			}
			if (index >= _source.length) {
				if (value != null) {
					_source.length = index;
					_source[index] = value;
				}
			} else if (index == _source.length - 1) {
				if (value == null) {
					resetLength();
				}
			}
			change(new GListChange(GListChange.UPDATE, index));
		}

		public function getAt(value : int) : * {
			if ( value < 0 || value >= _source.length) {
				return null;
			}
			return _source[value];
		}

		public function set source(value : Object) : void {
			if (_source == value) {
				return;
			}
			_source = Vector.<Object>(value);
			resetLength();
			change(new GListChange(GListChange.RESET));
		}

		public function get length() : int {
			return _source.length;
		}
	}
}
