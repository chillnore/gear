package gear.ui.skin.pb {
	import gear.log4a.LogError;
	import gear.ui.manager.UIManager;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;

	/**
	 * @author admin
	 */
	public class MCPBSkin implements IPBSkin {
		private var _mc : MovieClip;
		private var _trackSkin : DisplayObject;
		private var _barSkin : DisplayObject;
		private var _polledSkin : DisplayObject;
		private var _mode : int;
		private var _scale : int;
		private var _padding : int;
		private var _percent : Number;

		public function MCPBSkin(mc : MovieClip) {
			if (mc == null) {
				throw new LogError("mc is null!");
			}
			_mc = mc;
			_mc.gotoAndStop(1);
			_mc.x = 0;
			_mc.y = 0;
			_mc.mouseEnabled = _mc.mouseChildren = false;
			_trackSkin = _mc.getChildByName("trackSkin");
			_barSkin = _mc.getChildByName("barSkin");
			_padding = _barSkin.x;
			_polledSkin = _mc.getChildByName("polledSkin");
		}

		public function addTo(parent : DisplayObjectContainer, mode : int, scale : int, padding : int) : void {
			padding;
			parent.addChild(_trackSkin);
			_mode = mode;
			if (_mode == PBMode.MANUAL) {
				parent.addChild(_barSkin);
			} else if (_mode == PBMode.POLLED) {
				parent.addChild(_polledSkin);
			}
			_scale = scale;
		}

		public function setSize(width : int, height : int) : void {
			_trackSkin.width = width;
			_trackSkin.height = height;
			if (_scale == PBScale.SCALE) {
				_barSkin.width = width - _padding * 2;
				_barSkin.height = height - _padding * 2;
			} else if (_scale == PBScale.MASK) {
				_barSkin.scrollRect = new Rectangle(0, 0, width - _padding * 2, height - _padding * 2);
			} else if (_scale == PBScale.FRAME) {
				if (_barSkin is MovieClip) {
					MovieClip(_barSkin).gotoAndStop(1);
				}
			}
			if (_polledSkin != null) {
				_polledSkin.width = width;
				_polledSkin.height = height;
			}
		}

		public function clone() : IPBSkin {
			return new MCPBSkin(UIManager.cloneSkin(_mc) as MovieClip);
		}

		public function get width() : int {
			return _trackSkin.width;
		}

		public function get height() : int {
			return _trackSkin.height;
		}

		public function set percent(value : Number) : void {
			if (_percent == value) return;
			_percent = value;
			var width : int = Math.round(_percent * (_trackSkin.width - _padding * 2));
			if (_scale == PBScale.SCALE) {
				_barSkin.width = width;
			} else if (_scale == PBScale.MASK) {
				_barSkin.scrollRect = new Rectangle(0, 0, width, _trackSkin.height - _padding * 2);
			} else if (_scale == PBScale.FRAME) {
				if (_barSkin is MovieClip) {
					MovieClip(_barSkin).gotoAndStop(Math.round(MovieClip(_barSkin).totalFrames * _percent));
				}
			}
		}

		public function set mode(value : int) : void {
		}
	}
}
