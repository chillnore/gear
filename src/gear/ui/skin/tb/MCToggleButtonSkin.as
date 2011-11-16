package gear.ui.skin.tb {
	import gear.log4a.LogError;
	import gear.ui.core.PhaseState;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.utils.getQualifiedClassName;

	/**
	 * 模板按钮影片皮肤
	 * 
	 * @author bright
	 * @version 20110222
	 */
	public class MCToggleButtonSkin implements IToggleButtonSkin {
		private var _mc : MovieClip;
		private var _width : int;
		private var _height : int;
		private var _phase : int;
		private var _selected : Boolean;
		private var _upFrame : int;
		private var _overFrame : int;
		private var _downFrame : int;
		private var _selectedUpFrame : int;
		private var _selectedOverFrame : int;
		private var _selectedDownFrame : int;
		private var _disabledFrame : int;

		private function update() : void {
			if (_phase == PhaseState.DISABLED) {
				_mc.gotoAndStop(_disabledFrame);
			} else if (_phase == PhaseState.UP) {
				_mc.gotoAndStop(_selected ? _selectedUpFrame : _upFrame);
			} else if (_phase == PhaseState.OVER) {
				_mc.gotoAndStop(_selected ? _selectedOverFrame : _overFrame);
			} else if (_phase == PhaseState.DOWN) {
				_mc.gotoAndStop(_selected ? _selectedDownFrame : _downFrame);
			}
		}

		public function MCToggleButtonSkin(mc : MovieClip) {
			_mc = mc;
			_mc.gotoAndStop(1);
			_mc.x = 0;
			_mc.y = 0;
			_width = Math.round(_mc.width);
			_height = Math.round(_mc.height);
			_mc.width = _width;
			_mc.height = _height;
			_mc.mouseEnabled = _mc.mouseChildren = false;
			if (_mc.totalFrames == 1) {
				_upFrame = _overFrame = _downFrame = _selectedUpFrame = _selectedOverFrame = _selectedDownFrame = _disabledFrame = 1;
			} else if (_mc.totalFrames == 2) {
				_upFrame = 1;
				_overFrame = 1;
				_downFrame = 1;
				_selectedUpFrame = 2;
				_selectedOverFrame = 2;
				_selectedDownFrame = 2;
				_disabledFrame = 1;
			} else if (_mc.totalFrames == 3) {
				_upFrame = 2;
				_overFrame = 2;
				_downFrame = 2;
				_selectedUpFrame = 3;
				_selectedOverFrame = 3;
				_selectedDownFrame = 3;
				_disabledFrame = 2;
			} else if (_mc.totalFrames == 4) {
				_upFrame = 2;
				_overFrame = 2;
				_downFrame = 2;
				_selectedUpFrame = 3;
				_selectedOverFrame = 3;
				_selectedDownFrame = 3;
				_disabledFrame = 4;
			} else if (_mc.totalFrames == 5) {
				_upFrame = 2;
				_overFrame = 2;
				_downFrame = 2;
				_selectedUpFrame = 4;
				_selectedOverFrame = 4;
				_selectedDownFrame = 4;
				_disabledFrame = 5;
			} else if (_mc.totalFrames == 6) {
				_upFrame = 1;
				_overFrame = 2;
				_downFrame = 3;
				_selectedUpFrame = 4;
				_selectedOverFrame = 5;
				_selectedDownFrame = 6;
				_disabledFrame = 1;
			} else {
				throw new LogError("nonsupport totalFrames=" + _mc.totalFrames);
			}
		}

		public function set disabledSkin(value : DisplayObject) : void {
		}

		public function get mc() : MovieClip {
			return _mc;
		}

		public function setSize(width : int, height : int) : void {
			if (_width != width) {
				_width = width;
				_mc.width = width;
			}
			if (_height != height) {
				_height = height;
				_mc.height = height;
			}
		}

		public function addTo(parent : DisplayObjectContainer) : void {
			if (_mc.parent != parent) {
				parent.addChild(_mc);
			}
		}

		public function clone() : IToggleButtonSkin {
			var name : String = getQualifiedClassName(_mc);
			if (name == "flash.display::MovieClip") {
				return null;
			} else {
				var ref : Object = _mc.constructor;
				var clone_mc : MovieClip = new ref();
				return new MCToggleButtonSkin(clone_mc);
			}
		}

		public function get width() : int {
			return _width;
		}

		public function get height() : int {
			return _height;
		}

		public function set phase(value : int) : void {
			_phase = value;
			update();
		}

		public function set selected(value : Boolean) : void {
			_selected = value;
			update();
		}
	}
}
