package gear.log4a {
	import gear.net.AssetData;
	import gear.ui.containers.GTitleWindow;
	import gear.ui.controls.GButton;
	import gear.ui.controls.GTextArea;
	import gear.ui.controls.GTextInput;
	import gear.ui.core.GAlign;
	import gear.ui.data.GButtonData;
	import gear.ui.data.GTextAreaData;
	import gear.ui.data.GTextInputData;
	import gear.ui.data.GTitleWindowData;
	import gear.ui.layout.GLayout;
	import gear.ui.manager.UIManager;
	import gear.ui.skin.SkinStyle;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.utils.Dictionary;

	/**
	 * UI日志输出源
	 * 
	 * @author bright
	 * @version 20110923
	 */
	public class UIAppender extends GTitleWindow implements IAppender {
		public static const CLEAR : String = "clear";
		public static const QUIT : String = "quit";
		/**
		 * @private
		 */
		protected var _formatter : ILogFormatter;
		private var _debug_ta : GTextArea;
		private var _commond_ti : GTextInput;
		private var _run_btn : GButton;
		private var _downKey : Dictionary;
		private var _debuger : IDebugger;

		private function initData() : void {
			_data.modal = true;
			_data.titleBarData.bgAsset = new AssetData("GTitleBar_bgSkin");
			_data.panelData.bgSkin = UIManager.getSkin(new AssetData(SkinStyle.panel_bgSkin, AssetData.AS_LIB));
			_data.width = 800;
			_data.height = 500;
			_data.align = new GAlign(-1, -1, -1, -1, 0, 0);
			_data.titleBarData.labelData.text = "系统日志";
			_data.titleBarData.labelData.align = new GAlign(8, -1, -1, -1, -1, 1);
		}

		private function initView() : void {
			createTextArea();
			createTextInput();
			createButton();
			_downKey = new Dictionary(true);
			_formatter = new CSSLogFormatter();
		}

		private function initEvents() : void {
			_commond_ti.addEventListener(TextEvent.TEXT_INPUT, textInputHandler);
			_commond_ti.addEventListener(GTextInput.ENTER, enterHandler);
			_data.parent.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			_run_btn.addEventListener(MouseEvent.CLICK, run_clickHandler);
		}

		private function createTextArea() : void {
			var data : GTextAreaData = new GTextAreaData();
			data.textFormat.leading = 3;
			data.styleSheet.parseCSS(CSSLogFormatter.cssText);
			data.textFieldFilters = UIManager.getEdgeFilters(0x000000, 0.5);
			data.editable = false;
			data.align = new GAlign(5, 5, 5, 30, -1, -1);
			data.maxLines = 100;
			data.edlim = "</p>";
			_debug_ta = new GTextArea(data);
			_contentPanel.add(_debug_ta);
		}

		private function createTextInput() : void {
			var data : GTextInputData = new GTextInputData();
			data.textFieldFilters = UIManager.getEdgeFilters(0x000000, 1);
			data.maxChars = 100;
			data.align = new GAlign(5, 70, -1, 5, -1, -1);
			_commond_ti = new GTextInput(data);
			_contentPanel.add(_commond_ti);
		}

		private function createButton() : void {
			var data : GButtonData = new GButtonData();
			data.labelData.text = "Run";
			data.width = 50;
			data.height = 26;
			data.align = new GAlign(-1, 10, -1, 4, -1, -1);
			_run_btn = new GButton(data);
			_contentPanel.add(_run_btn);
		}

		private function textInputHandler(event : TextEvent) : void {
			if (event.text.charCodeAt(0) == 4) {
				event.preventDefault();
			}
		}

		private function enterHandler(event : Event) : void {
			run();
		}

		private function keyUpHandler(event : KeyboardEvent) : void {
			if (event.ctrlKey && event.keyCode == 188) {
				if (parent == null) {
					show();
					_commond_ti.setFocus();
					GLayout.layout(this);
				} else {
					hide();
				}
			}
		}

		/**
		 * @private
		 */
		private function run_clickHandler(event : MouseEvent) : void {
			run();
		}

		/**
		 * @private
		 */
		protected function run() : void {
			var params : Array = _commond_ti.text.split(" ");
			_commond_ti.clear();
			if (params.length == 0) {
				return;
			}
			var perfix : String = params.shift();
			switch(perfix) {
				case CLEAR:
					_debug_ta.clear();
					break;
				case QUIT:
					hide();
					break;
				default:
					if (_debuger != null) {
						params.unshift(perfix);
						_debuger.debug(params);
					}
					break;
			}
		}

		public function UIAppender(parent : Sprite) {
			_data = new GTitleWindowData();
			_data.parent = parent;
			initData();
			super(_data);
			initView();
			initEvents();
		}

		public function set debuger(value : IDebugger) : void {
			_debuger = value;
		}

		/**
		 * @inheritDoc
		 */
		public function append(data : LoggingData) : void {
			var message : String = _formatter.format(data);
			_debug_ta.appendHtmlText(message);
		}
	}
}
