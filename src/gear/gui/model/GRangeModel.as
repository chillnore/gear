package gear.gui.model {
	/**
	 * @author bright
	 */
	public class GRangeModel {
		protected var _min:Number;
		protected var _max:Number;
		protected var _value:Number;
		protected var _oldValue:Number;
		protected var _percent:Number;
		protected var _oldPercent:Number;
		protected var _zeroPercent:Number;
		protected var _onChange:Function;
		
		protected function reset():void{
			_oldPercent = _percent;
			_percent = (_value - _min) / (_max - _min);
			_zeroPercent = (0 - _min) / (_max - _min);
			if(_onChange!=null){
				_onChange();
			}
		}
		
		public function GRangeModel(min:Number=0,max:Number=100,value:Number=0){
			_value=value;
			_min=min;
			_max=max;
			reset();
		}
		
		public function set onChange(value:Function):void{
			_onChange=value;
		}
		
		public function resetRange(value : Number, min : Number, max : Number) : void {
			_value = value;
			_min = min;
			_max = max;
			reset();
		}
		
		public function set min(n : Number) : void {
			if (_min == n) {
				return;
			}
			_min = n;
			reset();
		}

		public function get min() : Number {
			return _min;
		}
		
		public function set value(n : Number) : void {
			n = Math.max(_min, Math.min(_max, n));
			if (_value == n) {
				return;
			}
			_oldValue = _value;
			_value = n;
			reset();
		}
		
		public function get value() : Number {
			return _value;
		}
		
		public function get oldValue() : Number {
			return _oldValue;
		}
		
		public function set max(n : Number) : void {
			if (_max == n) {
				return;
			}
			_max = n;
			reset();
		}

		public function get max() : Number {
			return _max;
		}
		
		public function get percent() : Number {
			return _percent;
		}

		public function get oldPercent() : Number {
			return _oldPercent;
		}

		public function get zeroPercenr() : Number {
			return _zeroPercent;
		}
	}
}
