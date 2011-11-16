package gear.effect {
	import gear.render.RenderCall;
	import gear.render.FrameRender;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * Game Effect
	 * 
	 * @author bright
	 * @version 20101008
	 */
	public class GEffect extends EventDispatcher {
		public static const END : String = "end";
		protected var _delay : int;
		protected var _duration : int;
		protected var _target : Sprite;
		protected var _timer : RenderCall;

		protected function onChangeTarget() : void {
		}

		protected function next() : void {
		}

		public function GEffect(duration : int, delay : int = 60) {
			_duration = duration;
			_delay = delay;
			_timer = new RenderCall(next, delay);
		}

		public function set target(value : Sprite) : void {
			_target = value;
			onChangeTarget();
		}

		public function set duration(value : int) : void {
			_duration = value;
		}

		public function start() : void {
			if (_target == null) {
				stop();
				return;
			}
			next();
			FrameRender.instance.add(_timer);
		}

		public function stop() : void {
			FrameRender.instance.remove(_timer);
			dispatchEvent(new Event(GEffect.END));
		}

		public function dispose() : void {
		}
	}
}
