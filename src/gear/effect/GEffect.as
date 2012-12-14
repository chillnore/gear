package gear.effect {
	import gear.render.GRenderCall;
	import gear.render.GFrameRender;

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
		protected var _timer : GRenderCall;

		protected function onChangeTarget() : void {
		}

		protected function next() : void {
		}

		public function GEffect(duration : int, delay : int = 60) {
			_duration = duration;
			_delay = delay;
			_timer = new GRenderCall(next, delay);
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
			GFrameRender.instance.add(_timer);
		}

		public function stop() : void {
			GFrameRender.instance.remove(_timer);
			dispatchEvent(new Event(GEffect.END));
		}

		public function dispose() : void {
		}
	}
}
