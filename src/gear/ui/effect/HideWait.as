package gear.ui.effect {
	import flash.utils.clearTimeout;

	import gear.ui.core.GBase;

	import flash.display.DisplayObject;
	import flash.utils.setTimeout;

	/**
	 * @author flashpf
	 */
	public class HideWait implements IEffect {
		protected var _wait : int;
		protected var _target : DisplayObject;
		protected var _id : uint;

		protected function hide() : void {
			_id = 0;
			if (_target is GBase) {
				GBase(_target).hide();
			} else if (_target.parent != null) {
				_target.parent.removeChild(_target);
			}
		}

		public function HideWait(wait : int) {
			_wait = wait;
		}

		public function set target(value : DisplayObject) : void {
			_target = value;
		}

		public function start() : void {
			if (_id != 0) {
				clearTimeout(_id);
			}
			_id = setTimeout(hide, _wait);
		}
	}
}
