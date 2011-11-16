package gear.ui.skin.pb {
	import gear.ui.manager.UIManager;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;

	/**
	 * @author admin
	 */
	public class PBSkin implements IPBSkin {
		private var _trackSkin : DisplayObject;
		private var _barSkin : DisplayObject;
		private var _polledSkin : DisplayObject;
		private var _mode : int;
		private var _scale : int;
		private var _padding : int;
		private var _percent : Number;

		public function PBSkin(trackSkin : DisplayObject, barSkin : DisplayObject, polledSkin : DisplayObject) {
			_trackSkin = trackSkin;
			_barSkin = barSkin;
			_polledSkin = polledSkin;
		}

		public function addTo(parent : DisplayObjectContainer, mode : int, scale : int, padding : int) : void {
			parent.addChild(_trackSkin);
			_mode = mode;
			if (_mode == PBMode.MANUAL) {
				parent.addChild(_barSkin);
			} else if (_mode == PBMode.POLLED) {
				parent.addChild(_polledSkin);
			}
			_scale = scale;
			_padding = padding;
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

		public function get width() : int {
			return _trackSkin.width;
		}

		public function get height() : int {
			return _trackSkin.height;
		}

		public function clone() : IPBSkin {
			return new PBSkin(UIManager.cloneSkin(_trackSkin), UIManager.cloneSkin(_barSkin), UIManager.cloneSkin(_polledSkin));
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
			value;
		}
	}
}
