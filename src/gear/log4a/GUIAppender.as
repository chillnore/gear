package gear.log4a {
	import gear.gui.containers.GPanel;
	import gear.gui.controls.GButton;
	import gear.gui.controls.GTextArea;
	import gear.gui.controls.GTextInput;
	import gear.gui.core.GAlign;
	import gear.gui.utils.GUIUtil;
	import gear.utils.GSystemUtil;

	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	/**
	 * UI日志输出源
	 * 
	 * @author bright
	 * @version 20130307
	 */
	public class GUIAppender extends GPanel implements IGAppender {
		protected var _debug_ta : GTextArea;
		protected var _commond_ti : GTextInput;
		protected var _run_btn : GButton;
		protected var _close_btn : GButton;
		protected var _formatter : GCSSLogFormatter;
		protected var _debugger : IGDebugger;

		override protected function onShow() : void {
			super.onShow();
			_commond_ti.setFocus();
		}

		protected function keyDownHandler(event : KeyboardEvent) : void {
			if (event.ctrlKey && event.keyCode == Keyboard.COMMA) {
				event.preventDefault();
			}
		}

		protected function keyUpHandler(event : KeyboardEvent) : void {
			if (event.ctrlKey && event.keyCode == Keyboard.COMMA) {
				parent == null ? show() : hide();
			}
		}

		/**
		 * 初始化视图
		 */
		protected function initView() : void {
			align = new GAlign(10, 10, 10, 10, 0, 0);
			_debug_ta = new GTextArea();
			_debug_ta.align = new GAlign(5, 5, 5, 30, -1, -1);
			_debug_ta.editable = false;
			_debug_ta.maxLines = 100;
			add(_debug_ta);
			_commond_ti = new GTextInput();
			_commond_ti.align = new GAlign(5, 115, -1, 5, -1, -1);
			add(_commond_ti);
			_run_btn = new GButton();
			_run_btn.text = "执行";
			_run_btn.width = 50;
			_run_btn.align = new GAlign(-1, 60, -1, 5, -1, -1);
			add(_run_btn);
			_close_btn = new GButton();
			_close_btn.text = "退出";
			_close_btn.width = 50;
			_close_btn.align = new GAlign(-1, 5, -1, 5, -1, -1);
			add(_close_btn);
			_formatter = new GCSSLogFormatter();
			_debug_ta.styleSheet = _formatter.styleSheet;
		}

		protected function initEvent() : void {
			_commond_ti.onEnter = onRun;
			//_run_btn.onClick = onRun;
			//_close_btn.onClick = hide;
			GUIUtil.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			GUIUtil.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}

		protected function onRun() : void {
			var params : Array = _commond_ti.text.split(" ");
			_commond_ti.clear();
			if (params.length == 0) {
				return;
			}
			var perfix : String = params.shift();
			switch(perfix) {
				case "c":
					_debug_ta.clear();
					break;
				case "q":
					hide();
					break;
				case "i":
					GLogger.info(GSystemUtil.getInfo());
					break;
				default:
					if (_debugger != null) {
						params.unshift(perfix);
						_debugger.debug(params);
					}
					break;
			}
		}

		public function GUIAppender() {
			initView();
			initEvent();
		}

		public function append(data : GLogData) : void {
			var message : String = _formatter.format(data);
			_debug_ta.appendHtmlText(message);
		}
	}
}
