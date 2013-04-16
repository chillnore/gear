package gear.gui.controls {
	import gear.gui.core.GAlignLayout;
	import gear.gui.core.GAlign;
	import gear.gui.core.GAutoSize;
	import gear.gui.core.GBase;
	import gear.gui.core.GPhase;
	import gear.gui.core.GScaleMode;
	import gear.gui.skin.IGSkin;
	import gear.gui.utils.GUIUtil;
	import gear.log4a.GLogger;

	import flash.display.BitmapData;
	import flash.events.MouseEvent;

	/**
	 * 按钮控件
	 * 
	 * @author bright
	 * @version 20130116
	 */
	public class GButton extends GBase {
		protected var _skin : IGSkin;
		protected var _label : GLabel;
		protected var _phase : int;
		protected var _lockPhase : int;
		protected var _onClick : Function;

		override protected function preinit() : void {
			_skin = GUIUtil.theme.buttonSkin;
			_scaleMode = GScaleMode.SCALE;
			_autoSize = GAutoSize.NONE;
			_padding.hdist = 6;
			_padding.vdist = 2;
			_lockPhase = GPhase.NONE;
			callLater(changePhase);
			setSize(60, 22);
		}

		override protected function create() : void {
			_skin.addTo(this, 0);
			_label = new GLabel();
			_label.align = GAlign.CENTER;
			addChild(_label);
		}

		override protected function resize() : void {
			_skin.setSize(_width, _height);
			callLater(changeLayout);
		}

		protected function changeLayout() : void {
			if (_autoSize == GAutoSize.AUTO_SIZE) {
				forceSize(_padding.left + _label.width + _padding.right, _padding.top + _label.height + _padding.bottom);
			} else if (_autoSize == GAutoSize.AUTO_WIDTH) {
				forceSize(_padding.left + _label.width + _padding.right, _height);
			}
			GAlignLayout.layout(_label);
		}

		override protected  function onShow() : void {
			super.onShow();
			addEvent(this, MouseEvent.ROLL_OVER, mouseHandler);
			addEvent(this, MouseEvent.ROLL_OUT, mouseHandler);
			addEvent(this, MouseEvent.MOUSE_DOWN, mouseHandler);
			addEvent(this, MouseEvent.MOUSE_UP, mouseHandler);
			addEvent(this, MouseEvent.CLICK, clickHandler);
		}

		override protected function onEnabled() : void {
			_phase = _enabled ? GPhase.UP : GPhase.DISABLED;
			callLater(changePhase);
		}

		protected function mouseHandler(event : MouseEvent) : void {
			if (!_enabled) {
				return;
			}
			if (event.type == MouseEvent.ROLL_OVER) {
				_phase = GPhase.OVER;
			} else if (event.type == MouseEvent.ROLL_OUT) {
				_phase = GPhase.UP;
			} else if (event.type == MouseEvent.MOUSE_DOWN) {
				_phase = GPhase.DOWN;
			} else if (event.type == MouseEvent.MOUSE_UP) {
				_phase = (event.currentTarget == this) ? GPhase.OVER : GPhase.UP;
			}
			callLater(changePhase);
		}

		protected function clickHandler(event : MouseEvent) : void {
			if (_onClick == null) {
				return;
			}
			try {
				_onClick.apply(null, _onClick.length < 1 ? null : [this]);
			} catch(e : Error) {
				GLogger.error(e.getStackTrace());
			}
		}

		protected function changePhase() : void {
			var value : int = (_lockPhase != GPhase.NONE ? _lockPhase : _phase);
			_skin.phase = value;
			_label.phase = value;
		}

		public function GButton() {
		}

		/**
		 * 设置锁定阶段
		 */
		public function set lockPhase(value : int) : void {
			if (_lockPhase == value) {
				return;
			}
			_lockPhase = value;
			callLater(changePhase);
		}

		public function set skin(value : IGSkin) : void {
			if (value == null || _skin == value) {
				return;
			}
			if (_skin != null) {
				_skin.remove();
			}
			_skin = value;
			_skin.addTo(this);
			_scaleMode=_skin.scaleMode;
			if (_scaleMode == GScaleMode.FIT_SIZE) {
				forceSize(_skin.width, _skin.height);
			}
			callLater(changePhase);
		}

		public function setLabelPhaseColor(phase : int, color : uint) : void {
			_label.setPhaseColor(phase, color);
		}

		public function set text(value : String) : void {
			_label.text = value;
			callLater(changeLayout);
		}

		public function get text() : String {
			return _label.text;
		}

		public function set icon(value : BitmapData) : void {
			_label.icon = value;
			callLater(changeLayout);
		}

		public function set onClick(value : Function) : void {
			_onClick = value;
		}
	}
}