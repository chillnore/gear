package gear.codec.swf.data.shape {
	import gear.codec.swf.GSwfStream;

	/**
	 * @author bright
	 */
	public class GSwfShapeRecordStyleChange {
		public var stateNewStyles : int;
		public var stateLineStyle : int;
		public var stateFillStyle1 : int;
		public var stateFillStyle0 : int;
		public var stateMoveTo : int;
		public var moveDeltaX : int;
		public var moveDeltaY : int;
		public var fillStyle0 : int;
		public var fillStyle1 : int;
		protected  var _lineStyle : int;
		protected var _fillStyles : Vector.<GSwfFillStyle>;
		protected var _lineStyles : Vector.<GSwfLineStyle>;

		public function GSwfShapeRecordStyleChange() {
			_fillStyles = new Vector.<GSwfFillStyle>();
			_lineStyles = new Vector.<GSwfLineStyle>();
		}

		public function decode(data : GSwfStream, numFillBits : int, numLineBits : int, level : int) : void {
			stateNewStyles = data.readUB(1);
			stateLineStyle = data.readUB(1);
			stateFillStyle1 = data.readUB(1);
			stateFillStyle0 = data.readUB(1);
			stateMoveTo = data.readUB(1);
			var bits : int;
			if (stateMoveTo == 1) {
				bits = data.readUB(5);
				moveDeltaX = data.readSB(bits);
				moveDeltaY = data.readSB(bits);
			}
			fillStyle0 = (stateFillStyle0 == 1) ? data.readUB(numFillBits) : 0;
			fillStyle1 = (stateFillStyle1 == 1) ? data.readUB(numFillBits) : 0;
			_lineStyle = (stateLineStyle == 1) ? data.readUB(numLineBits) : 0;
			if (stateNewStyles == 1) {
				bits = data.readArrayLength();
				var fillStyle : GSwfFillStyle;
				for (var i : int = 0;i < bits;i++) {
					fillStyle = new GSwfFillStyle();
					fillStyle.decode(data, level);
					_fillStyles[i] = fillStyle;
				}
				bits = data.readArrayLength();
				var lineStyle : GSwfLineStyle;
				for (i = 0;i < numLineBits;i++) {
					lineStyle = new GSwfLineStyle();
					lineStyle.decode(data);
					_lineStyles[i] = lineStyle;
				}
			}
			data.resetBitPos();
		}
	}
}
