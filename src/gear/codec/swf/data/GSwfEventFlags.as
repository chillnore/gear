package gear.codec.swf.data {
	import gear.codec.swf.GSwfStream;

	/**
	 * @author bright
	 */
	public class GSwfEventFlags {
		protected var _eventKeyUp : Boolean;
		protected var _eventKeyDown : Boolean;
		protected var _eventMouseUp : Boolean;
		protected var _eventMouseDown : Boolean;
		protected var _eventMouseMove : Boolean;
		protected var _eventUnload : Boolean;
		protected var _eventEnterFrame : Boolean;
		protected var _eventLoad : Boolean;
		protected var _eventDragOver : Boolean;
		protected var _eventRollOut : Boolean;
		protected var _eventRollOver : Boolean;
		protected var _eventReleaseOutside : Boolean;
		protected var _eventRelease : Boolean;
		protected var _eventPress : Boolean;
		protected var _eventInitialize : Boolean;
		protected var _eventData : Boolean;
		protected var _eventConstruct : Boolean;
		protected var _eventKeyPress : Boolean;
		protected var _eventDragOut : Boolean;

		public function GSwfEventFlags() {
		}

		public function decode(data : GSwfStream) : void {
			//1字节flags
			_eventKeyUp = (data.readUB(1) == 1);
			_eventKeyDown = (data.readUB(1) == 1);
			_eventMouseUp = (data.readUB(1) == 1);
			_eventMouseDown = (data.readUB(1) == 1);
			_eventMouseMove = (data.readUB(1) == 1);
			_eventUnload = (data.readUB(1) == 1);
			_eventEnterFrame = (data.readUB(1) == 1);
			_eventLoad = (data.readUB(1) == 1);
			//1字节flags
			_eventDragOver = (data.readUB(1) == 1);
			_eventRollOut = (data.readUB(1) == 1);
			_eventRollOver = (data.readUB(1) == 1);
			_eventReleaseOutside = (data.readUB(1) == 1);
			_eventRelease = (data.readUB(1) == 1);
			_eventPress = (data.readUB(1) == 1);
			_eventInitialize = (data.readUB(1) == 1);
			_eventData = (data.readUB(1) == 1);
			// version>=6 2字节flags
			data.readUB(5);
			_eventConstruct = (data.readUB(1) == 1);
			_eventKeyPress = (data.readUB(1) == 1);
			_eventDragOut = (data.readUB(1) == 1);
			data.readUB(8);
		}
		
		public function get eventKeyPress():Boolean{
			return _eventKeyPress;
		}
	}
}
