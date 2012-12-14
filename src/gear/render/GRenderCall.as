package gear.render {
	import gear.log4a.GLogger;

	/**
	 * 帧渲染回调
	 * 
	 * @author bright
	 * @version 20121107
	 */
	public class GRenderCall implements IGFrame {
		private var _call : Function;
		private var _delay : int;
		private var _offset : int;
		private var _count : int;

		public function GRenderCall(call : Function, delay : int = 33) : void {
			_call = call;
			if (delay < 33) {
				_delay = 33;
			} else {
				_delay = delay;
			}
		}

		public function set delay(value : int) : void {
			_delay = value;
		}

		public function get count() : int {
			return _count;
		}

		public function reset() : void {
			_count = 0;
			_offset = 0;
		}

		public function refresh() : void {
			if (_delay > 33) {
				_offset += GFrameRender.elapsed;
				if (_offset < _delay) {
					return;
				}
				_offset -= _delay;
				_offset %= _delay;
			}
			try {
				_call();
			} catch(e : Error) {
				GFrameRender.instance.remove(this);
				GLogger.error(e.getStackTrace());
			}
			_count++;
		}
	}
}
