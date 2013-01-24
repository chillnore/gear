package gear.codec.gpk.tag {
	import flash.display.BitmapData;
	import flash.display.JPEGXREncoderOptions;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import gear.codec.core.GLoadBytes;
	import gear.gui.bd.GBDList;
	import gear.gui.bd.GBDUnit;


	/**
	 * @author bright
	 * @version 20121212
	 */
	public final class GpkTagLBD extends AGpkTag {
		public static const TYPE : String = "lbd";
		private var _list : GBDList;
		private var _total : int;
		private var _count : int;

		private function onLoadDone(i : int, offsetX : int, offsetY : int, bd : BitmapData) : void {
			_list.setAt(i, new GBDUnit(offsetX, offsetY, bd));
			if (++_count <_total) {
				return;
			}
			complete();
		}

		public function GpkTagLBD(key : String = "none", list : GBDList = null) : void {
			_key = key;
			_list = list;
		}

		override public function encode(output : ByteArray) : void {
			output.writeUTF(TYPE);
			var start : int = output.position;
			output.writeUnsignedInt(0);
			output.writeUTF(_key);
			var compressor : JPEGXREncoderOptions = new JPEGXREncoderOptions();
			compressor.quantization = 30;
			output.writeShort(_list.length);
			var ba : ByteArray;
			for each (var unit:GBDUnit in _list.list) {
				output.writeShort(unit.offsetX);
				output.writeShort(unit.offsetY);
				ba = new ByteArray();
				unit.bd.encode(unit.bd.rect, compressor, ba);
				output.writeUnsignedInt(ba.length);
				output.writeBytes(ba);
			}
			var end : int = output.position;
			output.position = start;
			output.writeUnsignedInt(end - start - 4);
			output.position = end;
		}

		override public function decode(input : ByteArray, onComplete : Function) : void {
			_onComplete = onComplete;
			_key = input.readUTF();
			_total = input.readUnsignedShort();
			_count = 0;
			_list = new GBDList(new Vector.<GBDUnit>(_total));
			var offsetX : int;
			var offsetY : int;
			var ba:ByteArray;
			var loadBytes : GLoadBytes;
			for (var i : int = 0;i < _total;i++) {
				offsetX = input.readShort();
				offsetY = input.readShort();
				ba = new ByteArray();
				input.readBytes(ba, 0, input.readUnsignedInt());
				loadBytes = new GLoadBytes(ba, onLoadDone, i, offsetX, offsetY);
			}
		}

		override public function addTo(content : Dictionary) : void {
			content[key] = _list;
		}
		
		override public function dispose():void{
			if(_list!=null){
				_list.dispose();
				_list=null;
			}
		}
	}
}
