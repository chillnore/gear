package gear.gui.model {
	import gear.log4a.GLogger;

	/**
	 * @author bright
	 */
	public class GListModel {
		protected var _source : Vector.<Object>;
		protected var _resets : Vector.<Function>;

		public function GListModel() {
			_resets = new Vector.<Function>();
		}
		
		public function get length():int{
			return _source.length;
		}
		
		public function getAt(value:int):Object{
			if(value<0||value>=_source.length){
				return null;
			}
			return _source[value];
		}

		public function set onReset(value : Function) : void {
			if (_resets.indexOf(value) == -1) {
				_resets.push(value);
			}
		}

		public function removeOnReset(value : Function) : void {
			var index : int = _resets.indexOf(value);
			if (index != -1) {
				_resets.splice(index, 1);
			}
		}

		public function set source(value : Object) : void {
			if(_source==value){
				return;
			}
			_source = Vector.<Object>(value);
			for each (var func:Function in _resets) {
				try {
					func();
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
		}
	}
}
