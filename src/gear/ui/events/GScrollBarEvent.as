package gear.ui.events {
	import flash.events.Event;

	/**
	 * GScrollBarEvent 滚动条控件事件
	 * 
	 * @author bright
	 * @version 20101009
	 */
	public class GScrollBarEvent extends Event {
		public static const SCROLL : String = "scroll";
		private var _direction : int;
		private var _delta : int;
		private var _position : int;

		public function GScrollBarEvent(direction : int, delta : int, position : int) {
			super(SCROLL, false, false);
			_direction = direction;
			_delta = delta;
			_position = position;
		}

		public function get direction() : int {
			return _direction;
		}

		public function get delta() : int {
			return _delta;
		}

		public function get position() : int {
			return _position;
		}

		override public function toString() : String {
			return formatToString("GScrollBarEvent", "type", "bubbles", "cancelable", "direction", "delta", "position");
		}

		override public function clone() : Event {
			return new GScrollBarEvent(_direction, _delta, _position);
		}
	}
}
