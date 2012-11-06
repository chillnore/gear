package gear.ui.controls {
	import gear.render.BDList;
	import gear.render.FrameRender;
	import gear.render.RenderCall;
	import gear.ui.bd.BDFont;
	import gear.ui.core.GBase;
	import gear.ui.data.GTimeStepperData;
	import gear.utils.GBDUtil;
	import gear.utils.GArrayUtil;

	import flash.events.Event;
	import flash.events.TimerEvent;

	/**
	 * 时间步进器控件
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public final class GTimeStepper extends GBase {
		private var _data : GTimeStepperData;
		private var _bf : BDFont;
		private var _timer : RenderCall;

		/**
		 * @private
		 */
		override protected function create() : void {
			var chars : Array = [":", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
			var widths : Array = GArrayUtil.repeat(28, chars.length);
			var list : BDList = GBDUtil.cutBD(_data.bdKey, _data.bdLib, widths);
			_bf = new BDFont(list, chars, widths, 41, 1);
			_bf.text = "00:00";
			_width = _bf.width;
			_height = _bf.height;
			addChild(_bf);
		}

		private function timerHandler(event : TimerEvent) : void {
			var c : int = _timer.count;
			var s : int = c % 60;
			var m : int = c / 60;
			_bf.text = (m < 10 ? "0" : "") + m + ":" + (s < 10 ? "0" : "") + s;
			if (c == _data.limit) {
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}

		/**
		 * @inheritDoc
		 */
		public function GTimeStepper(data : GTimeStepperData) {
			_data = data;
			super(data);
			_timer = new RenderCall(timerHandler, 1000);
		}

		/**
		 * 启动时间步进器
		 */
		public function start() : void {
			_bf.text = "00:00";
			_timer.reset();
			FrameRender.instance.add(_timer);
		}

		/**
		 * 停止时间步进器
		 */
		public function stop() : void {
			FrameRender.instance.remove(_timer);
			_bf.text = "00:00";
		}
	}
}
