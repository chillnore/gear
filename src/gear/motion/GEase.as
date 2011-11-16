package gear.motion {
	import gear.motion.easing.Linear;
	import gear.render.FrameRender;
	import gear.render.IFrame;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * 缓动管理器
	 * 
	 * @author bright
	 * @version 20101019
	 */
	public class GEase extends EventDispatcher implements IFrame {
		public static const END : String = "end";
		private var _target : Object;
		private var _duration : int;
		private var _ease : Function;
		private var _list : Array;

		public function GEase(target : Object = null, duration : int = 0, ease : Function = null) {
			_target = target;
			_duration = duration;
			_ease = (ease == null ? Linear.easeIn : ease);
			_list = new Array();
		}

		public function set target(target : Object) : void {
			_target = target;
			for each (var tween:IGTween in _list) {
				tween.target = _target;
			}
		}

		public function add(tween : IGTween) : void {
			tween.init(_target, _duration, _ease);
			_list.push(tween);
		}

		public function start() : void {
			if (_target == null) {
				return;
			}
			FrameRender.instance.add(this);
		}

		public function stop() : void {
			FrameRender.instance.remove(this);
			for each (var tween:IGTween in _list) {
				tween.reset();
			}
			dispatchEvent(new Event(END));
		}

		public function refresh() : void {
			var isEnd : Boolean = true;
			var tween : IGTween;
			for each (tween in _list) {
				if (tween.next()) {
					isEnd = false;
				}
			}
			if (isEnd) {
				stop();
			}
		}
	}
}
