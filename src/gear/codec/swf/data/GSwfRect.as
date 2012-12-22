package gear.codec.swf.data {
	/**
	 * @author bright
	 * @version 20121215
	 */
	public class GSwfRect {
		public var nbits : int;
		public var xmin : int;
		public var xmax : int;
		public var ymin : int;
		public var ymax : int;

		public function GSwfRect(){
		}
		
		public function toString():String{
			return "xmin="+xmin+",xmax="+xmax+",ymin="+ymin+",ymax="+ymax;
		}
	}
}
