package gear.gui.controls {
	import gear.gui.containers.GPanel;

	/**
	 * @author bright
	 */
	public class GAlert extends GPanel {
		public static const NONE : uint = 0;
		public static const OK : uint = 0x4;
		public static const CANCEL : uint = 0x8;
		public static const YES : uint = 0x1;
		public static const NO : uint = 0x2;
		protected var _label : GLabel;
		protected var _textInput : GTextInput;
		protected var _flag : uint;
		protected var _buttons : Vector.<GButton>;

		override protected function preinit() : void {
			_flag = 0x4;
			addRender(updateFlag);
		}

		override protected function create() : void {
			_label = new GLabel();
			add(_label);
			_textInput = new GTextInput();
			add(_textInput);
		}

		protected function updateFlag() : void {
		}

		public function GAlert() : void {
		}

		public function set flag(value : uint) : void {
			if (_flag == value) {
				return;
			}
			_flag = value;
			addRender(updateFlag);
		}
	}
}
