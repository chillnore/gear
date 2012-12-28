package gear.gui.bd {
	/**
	 * 播放数据定义
	 * 
	 * @see gear.gui.bd.GBDPlayer
	 * @author bright
	 * @version 20121227
	 */
	public class GPlayData {
		protected var _delay : int;
		protected var _frames:Vector.<int>;
		protected var _loop : int;
		protected var _change : Function;
		protected var _complete : Function;

		public function GPlayData(delay : int = 33, frames :Vector.<int>= null, loop : int = 1) {
			_delay = delay;
			_frames = frames;
			_loop = loop;
		}

		public function get delay() : int {
			return _delay;
		}

		public function set frames(value :Vector.<int>) : void {
			_frames = value;
		}

		public function get frames() :Vector.<int>{
			return _frames;
		}

		public function get loop() : int {
			return _loop;
		}

		public function set change(value : Function) : void {
			_change = value;
		}

		public function get change() : Function {
			return _change;
		}

		public function set complete(value : Function) : void {
			_complete = value;
		}

		public function get complete() : Function {
			return _complete;
		}

		public function parseObj(value : Object) : void {
			_delay = (value.delay != null ? value.delay : 33);
			_frames = (value.frames != null ? value.frames : null);
			_loop = (value.loop != null ? value.loop : 1);
		}
	}
}
