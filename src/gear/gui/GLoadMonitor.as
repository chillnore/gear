package gear.gui {
	import gear.gui.containers.GPanel;
	import gear.gui.controls.GLabel;
	import gear.gui.controls.GProgressBar;
	import gear.gui.core.GAlign;
	import gear.net.GLoadModel;

	/**
	 * @author bright
	 */
	public class GLoadMonitor extends GPanel {
		protected var _label : GLabel;
		protected var _total_pb : GProgressBar;
		protected var _model:GLoadModel;
		protected var _time:int;

		private function initView() : void {
			_modal = true;
			align = GAlign.CENTER;
			setSize(400, 70);
			_label = new GLabel();
			_label.moveTo(10, 10);
			addChild(_label);
			_total_pb = new GProgressBar();
			_total_pb.align = new GAlign(10, 10, -1, 10, -1, -1);
			_total_pb.setSize(380, 8);
			addChild(_total_pb);
		}

		public function GLoadMonitor() {
			initView();
		}

		public function set model(value : GLoadModel) : void {
			_total_pb.model=value;
		}
	}
}
