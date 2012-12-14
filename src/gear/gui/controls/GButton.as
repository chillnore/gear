package gear.gui.controls {
	import gear.gui.core.GAlign;
	import gear.gui.core.GAlignLayout;
	import gear.gui.core.GAutoSizeMode;
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
	 * @version 20121204
	 */
	public class GButton extends GBase {
		protected var _phase : int;
		protected var _lockPhase:int;
		protected var _skin : IGSkin;
		protected var _label : GLabel;
		protected var _onClick : Function;

		override protected function preinit() : void {
			_scaleMode = GScaleMode.SCALE;
			_autoSize = GAutoSizeMode.NONE;
			_padding.hdist = 6;
			_padding.vdist = 2;
			_lockPhase=GPhase.NONE;
			setSize(60, 22);
			skin = GUIUtil.theme.buttonSkin;
		}

		override protected function create() : void {
			_label = new GLabel();
			_label.align = GAlign.CENTER;
			addChild(_label);
		}

		override protected function resize() : void {
			_skin.setSize(_width, _height);
			_skin.phase = _phase;
		}

		protected function update() : void {
			if (_autoSize == GAutoSizeMode.AUTO_SIZE) {
				forceSize(_padding.left + _label.width + _padding.right, _padding.top + _label.height + _padding.bottom);
			} else if (_autoSize == GAutoSizeMode.AUTO_WIDTH) {
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
			if (!_enabled) {
				_phase = GPhase.DISABLED;
			}
		}

		protected function mouseHandler(event : MouseEvent) : void {
			event.stopImmediatePropagation();
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
			addRender(updatePhase);
		}

		protected function clickHandler(event : MouseEvent) : void {
			event.stopPropagation();
			if (_onClick == null) {
				return;
			}
			try {
				_onClick.apply(null, [this]);
			} catch(e : Error) {
				GLogger.error(e.getStackTrace());
			}
		}

		protected function updatePhase() : void {
			var value:int=(_lockPhase!=-1?_lockPhase:_phase);
			_skin.phase = value;
			_label.phase =value;
		}

		public function GButton() {
		}
		
		/**
		 * 设置锁定阶段
		 */
		public function set lockPhase(value:int):void{
			if(_lockPhase==value){
				return;
			}
			_lockPhase=value;
			addRender(updatePhase);
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
			if (_scaleMode == GScaleMode.FIT_SIZE) {
				forceSize(_skin.width, _skin.height);
			}
			addRender(updatePhase);
		}

		public function setLabelPhaseColor(phase : int, color : uint) : void {
			_label.setPhaseColor(phase, color);
		}

		public function set text(value : String) : void {
			_label.text = value;
			addRender(update);
		}

		public function set icon(value : BitmapData) : void {
			_label.icon = value;
			addRender(update);
		}

		public function set onClick(value : Function) : void {
			_onClick = value;
		}
	}
}