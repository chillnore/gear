package gear.codec.swf.data.shape {
	import gear.codec.swf.GSwfStream;

	/**
	 * @author bright
	 * @version 20121215
	 */
	public class GSwfShapeWithStyle {
		protected var _fillStyles : Vector.<GSwfFillStyle>;
		protected var _lineStyles : Vector.<GSwfLineStyle>;

		public function GSwfShapeWithStyle() {
			_fillStyles = new Vector.<GSwfFillStyle>();
			_lineStyles = new Vector.<GSwfLineStyle>();
		}

		public function decode(data : GSwfStream, level : int) : void {
			var numFillBits : int = data.readArrayLength();
			var fillStyle : GSwfFillStyle;
			for (var i : int = 0;i < numFillBits;i++) {
				fillStyle = new GSwfFillStyle();
				fillStyle.decode(data, level);
				_fillStyles[i] = fillStyle;
			}
			var numLineBits : int = data.readArrayLength();
			var lineStyle : GSwfLineStyle;
			for (i = 0;i < numLineBits;i++) {
				lineStyle = new GSwfLineStyle();
				lineStyle.decode(data);
				_lineStyles[i] = lineStyle;
			}
			var typeFlag : int;
			while (true) {
				data.resetBitPos();
				typeFlag = data.readUB(1);
				if (typeFlag == 1) {
					var straightFlag : int = data.readUB(1);
					var bits : int;
					if (straightFlag == 1) {
						bits = data.readUB(4) + 2;
						var generalLineFlag : int = data.readUB(1);
						var vertLineFlag : int = 0;
						if (generalLineFlag == 0) {
							vertLineFlag = data.readSB(1);
						}
						if (generalLineFlag == 1 || vertLineFlag == 0) {
							var deltaX : int = data.readSB(bits);
						}
						if (generalLineFlag == 1 || vertLineFlag == 1) {
							var deltaY : int = data.readSB(bits);
						}
						deltaX;
						deltaY;
						trace(deltaX,deltaY);
					} else {
						bits = data.readUB(4) + 2;
						var controlDeltaX : int = data.readSB(bits);
						var controlDeltaY : int = data.readSB(bits);
						var anchorDeltaX : int = data.readSB(bits);
						var anchorDeltaY : int = data.readSB(bits);
						controlDeltaX;
						controlDeltaY;
						anchorDeltaX;
						anchorDeltaY;
					}
				} else {
					var endOfShape : int = data.readUB(5);
					if (endOfShape == 0) {
						break;
					} else {
						var styleChangeRecord : GSwfShapeRecordStyleChange = new GSwfShapeRecordStyleChange();
						styleChangeRecord.decode(data, numFillBits, numLineBits, level);
					}
				}
			}
		}
	}
}
