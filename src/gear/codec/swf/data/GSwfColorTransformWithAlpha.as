package gear.codec.swf.data {
	import gear.codec.swf.GSwfStream;

	/**
	 * @author bright
	 */
	public class GSwfColorTransformWithAlpha {
		protected var _hasAddTrems : Boolean;
		protected var _hasMultTrems : Boolean;
		protected var _rMult : int;
		protected var _gMult : int;
		protected var _bMult : int;
		protected var _aMult : int;
		protected var _rAdd : int;
		protected var _gAdd : int;
		protected var _bAdd : int;
		protected var _aAdd : int;

		public function GSwfColorTransformWithAlpha() {
		}

		public function decode(data : GSwfStream) : void {
			_hasAddTrems = (data.readUB(1) == 1);
			_hasMultTrems = (data.readUB(1) == 1);
			var bits : int = data.readUB(4);
			if (_hasMultTrems) {
				_rMult = data.readSB(bits);
				_gMult = data.readSB(bits);
				_bMult = data.readSB(bits);
				_aMult = data.readSB(bits);
			} else {
				_rMult = 1;
				_gMult = 1;
				_bMult = 1;
				_aMult = 1;
			}
			if (_hasAddTrems) {
				_rAdd = data.readSB(bits);
				_gAdd = data.readSB(bits);
				_bAdd = data.readSB(bits);
				_aAdd = data.readSB(bits);
			} else {
				_rAdd = 0;
				_gAdd = 0;
				_bAdd = 0;
				_aAdd = 0;
			}
			trace(_hasMultTrems, _hasAddTrems, _rMult, _gMult, _bMult, _aMult, _rAdd, _gAdd, _bAdd, _aAdd);
		}
	}
}
