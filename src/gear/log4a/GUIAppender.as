package gear.log4a {
	import gear.utils.GSystemUtil;
	import gear.gui.containers.GPanel;
	import gear.gui.controls.GButton;
	import gear.gui.controls.GTextArea;
	import gear.gui.controls.GTextInput;
	import gear.gui.core.GAlign;
	import gear.gui.utils.GUIUtil;

	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	/**
	 * UI日志输出源
	 * 
	 * @author bright
	 * @version 20130110
	 */
	public class GUIAppender extends GPanel implements IAppender {
		protected var _debug_ta : GTextArea;
		protected var _commond_ti : GTextInput;
		protected var _run_btn : GButton;
		protected var _formatter : ILogFormatter;
		protected var _debugger:IDebugger;
		
		override protected function onShow():void{
			super.onShow();
			_commond_ti.setFocus();
		}

		protected function keyUpHandler(event : KeyboardEvent) : void {
			if (event.ctrlKey && event.keyCode == Keyboard.S) {
				parent == null ? show() : hide();
			}
		}

		protected function initView() : void {
			align = new GAlign(10, 10, 10, 10, 0, 0);
			_debug_ta = new GTextArea();
			_debug_ta.align = new GAlign(5, 5, 5, 30, -1, -1);
			_debug_ta.editable = false;
			_debug_ta.maxLines = 100;
			add(_debug_ta);
			_commond_ti = new GTextInput();
			_commond_ti.align = new GAlign(5, 70, -1, 5, -1, -1);
			add(_commond_ti);
			_run_btn = new GButton();
			_run_btn.text = "执行";
			_run_btn.align = new GAlign(-1, 5, -1, 5, -1, -1);
			add(_run_btn);
			_formatter = new CSSLogFormatter();
			_commond_ti.onEnter = run;
			_run_btn.onClick = run;
			GUIUtil.root.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}
		
		protected function run():void{
			var params : Array = _commond_ti.text.split(" ");
			_commond_ti.clear();
			if (params.length == 0) {
				return;
			}
			var perfix : String = params.shift();
			switch(perfix) {
				case "clear":
					_debug_ta.clear();
					break;
				case "quit":
					hide();
					break;
				case "getInfo":
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
		}

		public function append(data : GLogData) : void {
			var message : String = _formatter.format(data);
			_debug_ta.appendHtmlText(message);
		}
	}
}
