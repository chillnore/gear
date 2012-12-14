package gear.codec.psd.data {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * Psd图层
	 * 
	 * @author bright
	 * @version 20121109
	 */
	public class GPsdLayer {
		public static const OTHER : int = 0;
		public static const FOLDER_OPEN : int = 1;
		public static const FOLDER_CLOSED : int = 2;
		public static const BOUNDING_SECTION : int = 3;
		public var bounds : Rectangle;
		public var channelCount : int;
		public var channels : Vector.<GPsdChannel>;
		public var blendModeKey : String;
		public var dividerBlendModeKey : String;
		public var alpha : Number;
		public var clipping : Boolean;
		public var transparencyProtected : Boolean;
		public var visible : Boolean;
		public var obsolete : Boolean;
		public var pixelDataIrrelevant : Boolean;
		public var mask : GPsdMask;
		public var name : String;
		public var unicodeName : String;
		public var nameId : int;
		public var id : int;
		public var type : int;
		public var referencePoint : Point;
		public var bitmap : Bitmap;
		public var bitmapData : BitmapData;
		public var filters : Array;

		/**
		
		
		 */
		public function GPsdLayer() {
			type = OTHER;
			filters = new Array();
		}
	}
}