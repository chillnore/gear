package gear.codec.gpk.tag {
	import gear.log4a.GLogger;

	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	/**
	 * @author bright
	 */
	public class AGpkTag{
		protected var _key:String;
		protected var _onComplete:Function;
		protected var _start : int;
		
		protected function complete():void{
			if (_onComplete != null) {
				try{
					_onComplete(this);
				}catch(e:Error){
					GLogger.error(e.getStackTrace());
				}
			}
		}

		public function AGpkTag() {
		}
		
		public function set key(value:String):void{
			_key=value;
		}
		
		public function get key():String{
			return _key;
		}
		
		public function encode(output : ByteArray) : void {
		}

		public function decode(input : ByteArray, onComplete : Function) : void {
		}
		
		public function addTo(content:Dictionary):void{
		}
	}
}
