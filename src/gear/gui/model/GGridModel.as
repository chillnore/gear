package gear.gui.model {
	import gear.log4a.GLogger;
	/**
	 * @author bright
	 */
	public class GGridModel {
		protected var _source : Vector.<Object>;
		protected var _change : Vector.<Function>;
		
		protected function change(value : GListChange) : void {
			for each (var change:Function in _change) {
				try {
					change.apply(null, [value]);
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
		}
		
		public function GGridModel(){
			_change = new Vector.<Function>();
		}
		
		public function set onChange(value : Function) : void {
			if (_change.indexOf(value) == -1) {
				_change.push(value);
			}
		}
		
		public function setAt(index : int, value : *) : void {
			if (_source == null || index < 0 || index >= _source.length) {
				return;
			}
			_source[index] = value;
			change(new GListChange(GListChange.UPDATE, index));
		}
		
		public function getAt(value : int) : * {
			if (_source == null || value < 0 || value >= _source.length) {
				return null;
			}
			return _source[value];
		}
		
		public function set source(value : Object) : void {
			if (_source == value) {
				return;
			}
			_source = Vector.<Object>(value);
			change(new GListChange(GListChange.RESET));
		}
	}
}
