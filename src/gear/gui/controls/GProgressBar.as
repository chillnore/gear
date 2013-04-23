package gear.gui.controls {
	import gear.gui.core.GBase;
	import gear.gui.core.GPhase;
	import gear.gui.core.GScaleMode;
	import gear.gui.model.GRangeModel;
	import gear.gui.skins.GProgressBarSkin;
	import gear.gui.skins.IGSkin;

	/**
	 * 进度条控件
	 * 
	 * @author bright
	 * @version 20121210
	 */
	public class GProgressBar extends GBase {
		public static const MANUAL : int = 0;
		public static const POLLED : int = 1;
		protected var _trackSkin : IGSkin;
		protected var _barSkin : IGSkin;
		protected var _model : GRangeModel;
		protected var _mode : int;
		protected var _min : int;
		protected var _max : int;
		protected var _value : int;

		override protected function preinit() : void {
			_trackSkin = GProgressBarSkin.trackSkin;
			_barSkin = GProgressBarSkin.barSkin;
			_model = new GRangeModel();
			_model.onChange = onModelChange;
			setSize(120, 8);
		}

		override protected function create() : void {
			_trackSkin.addTo(this, 0);
			_barSkin.addTo(this, 1);
		}

		override protected function resize() : void {
			_trackSkin.setSize(_width, _height);
			_barSkin.setSize(_model.percent * _width, _height);
		}

		protected function onModelChange() : void {
			_barSkin.setSize(_model.percent * _width, _height);
		}

		public function GProgressBar() {
		}

		public function set trackSkin(value : IGSkin) : void {
			if (_trackSkin == value) {
				return;
			}
			if (_trackSkin != null) {
				_trackSkin.remove();
			}
			_trackSkin = value;
			if (_trackSkin == null) {
				return;
			}
			_trackSkin.phase = (_enabled ? GPhase.UP : GPhase.DISABLED);
			_trackSkin.addTo(this, 0);
			if (_scaleMode == GScaleMode.FIT_SIZE) {
				forceSize(_trackSkin.width, _trackSkin.height);
			}
		}

		public function set barSkin(value : IGSkin) : void {
			if (_barSkin == value) {
				return;
			}
			if (_barSkin != null) {
				_barSkin.remove();
			}
			_barSkin = value;
			if (_barSkin == null) {
				return;
			}
			_barSkin.phase = (_enabled ? GPhase.UP : GPhase.DISABLED);
			_barSkin.addTo(this, 1);
		}

		public function set model(value : GRangeModel) : void {
			if (_model == value) {
				return;
			}
			if (_model != null) {
				_model.onChange = null;
			}
			_model = value;
			_model.onChange = onModelChange;
			_barSkin.setSize(_model.percent * _width, _height);
		}

		public function get model() : GRangeModel {
			return _model;
		}
	}
}
