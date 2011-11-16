package gear.ui.skin.button {
	import gear.log4a.LogError;
	import gear.ui.core.PhaseState;
	import gear.ui.manager.UIManager;

	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author bright
	 * @version 20101102
	 */
	public class MCButtonSkin implements IButtonSkin {
		private var _mc : MovieClip;
		private var _width : int;
		private var _height : int;
		private var _upFrame : int;
		private var _overFrame : int;
		private var _downFrame : int;
		private var _disabledFrame : int;

		public function MCButtonSkin(mc : MovieClip) {
			if (mc == null) {
				throw new LogError("mc is null!");
			}
			_mc = mc;
			_mc.gotoAndStop(1);
			_mc.x = 0;
			_mc.y = 0;
			_width = _mc.width;
			_height = _mc.height;
			_mc.width = Math.round(_width);
			_mc.height = Math.round(_height);
			_mc.mouseEnabled = _mc.mouseChildren = false;
			if (_mc.totalFrames == 1) {
				_upFrame = _overFrame = _downFrame = _disabledFrame = 1;
			} else if (mc.totalFrames == 2) {
				_upFrame = 1;
				_overFrame = 1;
				_downFrame = 2;
				_disabledFrame = 1;
			} else if (mc.totalFrames == 3) {
				_upFrame = 1;
				_overFrame = 2;
				_downFrame = 3;
				_disabledFrame = 1;
			} else if (mc.totalFrames == 4) {
				_upFrame = 1;
				_overFrame = 2;
				_downFrame = 3;
				_disabledFrame = 4;
			} else {
				throw new LogError("nonsupport totalFrames=" + _mc.totalFrames);
			}
		}

		public function get mc() : MovieClip {
			return _mc;
		}

		public function set phase(value : int) : void {
			if (value == PhaseState.UP) {
				_mc.gotoAndStop(_upFrame);
			} else if (value == PhaseState.OVER) {
				_mc.gotoAndStop(_overFrame);
			} else if (value == PhaseState.DOWN) {
				_mc.gotoAndStop(_downFrame);
			} else if (value == PhaseState.DISABLED) {
				_mc.gotoAndStop(_disabledFrame);
			}
			if (UIManager.root != null) {
				UIManager.root.stage.invalidate();
			}
		}

		public function addTo(parent : DisplayObjectContainer) : void {
			if (_mc.parent != parent) {
				parent.addChild(_mc);
			}
		}

		public function setSize(width : int, height : int) : void {
			_mc.width = width;
			_mc.height = height;
		}

		public function get width() : int {
			return _width;
		}

		public function get height() : int {
			return _height;
		}

		public function clone() : IButtonSkin {
			var name : String = getQualifiedClassName(_mc);
			if (name == "flash.display::MovieClip") {
				return null;
			} else {
				var ref : Object = _mc.constructor;
				var clone_mc : MovieClip = new ref();
				return new MCButtonSkin(clone_mc);
			}
		}
	}
}
