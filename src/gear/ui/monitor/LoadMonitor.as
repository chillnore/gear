package gear.ui.monitor {
	import gear.net.LoadModel;
	import gear.ui.containers.GPanel;
	import gear.ui.controls.GLabel;
	import gear.ui.controls.GProgressBar;
	import gear.ui.core.GAlign;
	import gear.ui.data.GLabelData;
	import gear.ui.data.GPanelData;
	import gear.ui.data.GProgressBarData;
	import gear.ui.layout.GLayout;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * LoadMonitor 加载监视器
	 * 
	 * @author bright
	 * @version 20101012
	 */
	public class LoadMonitor extends GPanel {
		protected var _label : GLabel;
		protected var _progressBar : GProgressBar;
		protected var _model : LoadModel;
		protected var _timeout : Timer;

		protected function initData() : void {
			_data.align = new GAlign(-1, -1, -1, -1, 0, 0);
			_data.padding = 0;
			_data.width = 400;
			_data.height = 70;
			_data.modal = true;
		}

		override protected function onShow() : void {
			super.onShow();
			GLayout.layout(this);
		}

		protected function initView() : void {
			addLabels();
			addProgressBars();
			_timeout = new Timer(500, 1);
			_timeout.addEventListener(TimerEvent.TIMER, timerHandler);
		}

		protected function addLabels() : void {
			var data : GLabelData = new GLabelData();
			data.x = 10;
			data.y = 10;
			data.color.upColor = 0xFFFF00;
			_label = new GLabel(data);
			add(_label);
		}

		protected function addProgressBars() : void {
			var data : GProgressBarData = new GProgressBarData();
			data.labelData.align = new GAlign(0, -1, 10, -1, -1, -1);
			data.x = 10;
			data.y = 35;
			data.width = 380;
			data.height = 10;
			_progressBar = new GProgressBar(data);
			add(_progressBar);
		}

		private function timerHandler(event : TimerEvent) : void {
			show();
		}

		private function initHandler(event : Event) : void {
			_progressBar.max = _model.totalProgress;
			_timeout.reset();
			_timeout.start();
		}

		protected function changeHandler(event : Event) : void {
			_progressBar.value = _model.progress;
			_progressBar.text = "speed:" + _model.speed + " KB/S";
		}

		private function completeHandler(event : Event) : void {
			if (_timeout.running)
				_timeout.stop();
			hide();
		}

		private function addModelEvents() : void {
			_model.addEventListener(Event.INIT, initHandler);
			_model.addEventListener(Event.CHANGE, changeHandler);
			_model.addEventListener(Event.COMPLETE, completeHandler);
		}

		private function removeModelEvents() : void {
			_model.removeEventListener(Event.INIT, initHandler);
			_model.removeEventListener(Event.CHANGE, changeHandler);
			_model.removeEventListener(Event.COMPLETE, completeHandler);
		}

		public function LoadMonitor(parent : Sprite) {
			_data = new GPanelData();
			_data.parent = parent;
			initData();
			super(_data);
			initView();
		}

		public function set model(value : LoadModel) : void {
			if (_model) {
				removeModelEvents();
			}
			_model = value;
			if (_model) {
				addModelEvents();
			}
		}

		public function set text(value : String) : void {
			_label.text = value;
		}
	}
}