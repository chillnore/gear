package gear.effect {
	import gear.render.GFrameRender;
	import gear.render.GRenderCall;

	import flash.display.DisplayObject;

	/**
	 * Game Effect
	 * 
	 * @author bright
	 * @version 20101008
	 */
	public class GEffect {
		protected var _delay : int;
		protected var _duration : int;
		protected var _target : DisplayObject;
		protected var _render : GRenderCall;

		protected function onChangeTarget() : void {
		}

		protected function next() : void {
		}

		public function GEffect(duration : int, delay : int = 60) {
			_duration = duration;
			_delay = delay;
			_render = new GRenderCall(next, delay);
		}

		public function set target(value : DisplayObject) : void {
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
			GFrameRender.instance.add(_render);
		}

		public function stop() : void {
			GFrameRender.instance.remove(_render);
		}

		public function dispose() : void {
		}
	}
}
