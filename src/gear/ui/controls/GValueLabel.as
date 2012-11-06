package gear.ui.controls {
	import gear.ui.layout.GLayout;
	import gear.ui.core.GBase;
	import gear.ui.core.ScaleMode;
	import gear.ui.data.GValueLabelData;

	/**
	 * @author suijiabin
	 */
	public class GValueLabel extends GBase {
		protected var _data : GValueLabelData;
		protected var _nameLabel : GLabel;
		protected var _valueLabel : GLabel;

		public function GValueLabel(data : GValueLabelData) {
			_data = data;
			super(_data);
		}

		override protected function layout() : void {
			_valueLabel.x = _nameLabel.width + _data.valueLableData.hGap;
			_valueLabel.y = _nameLabel.y = (height-_nameLabel.height)/2;
			if (_valueLabel.align) {
				GLayout.layout(_valueLabel);
			}
			if (_data.scaleMode == ScaleMode.NONE) {
				_valueLabel.moveTo(_data.valueLableData.x, _data.valueLableData.y);
				_nameLabel.moveTo(_data.nameLableData.x, _data.nameLableData.y);
			}
		}

		override protected function create() : void {
			_nameLabel = new GLabel(_data.nameLableData);
			_valueLabel = new GLabel(_data.valueLableData);
			addChild(_nameLabel);
			addChild(_valueLabel);
			layout();
		}

		public function get value() : String {
			return _valueLabel.text;
		}

		public function set value(value : String) : void {
			_valueLabel.htmlText = value;
		}

		public function get nameText() : String {
			return _nameLabel.text;
		}

		public function set nameText(value : String) : void {
			_nameLabel.text = value;
			layout();
		}

		public function set nameToolTipSource(value : *) : void {
			if (value is String)
				_data.nameLableData.toolTipData.labelData.text = value;
			if (_nameLabel.toolTip && _nameLabel.toolTip.parent)
				_nameLabel.toolTip.source = value;
		}

		public function set valueToolTipSource(value : *) : void {
			if (value is String)
				_data.valueLableData.toolTipData.labelData.text = value;
			if (_valueLabel.toolTip && _valueLabel.toolTip.parent)
				_valueLabel.toolTip.source = value;
		}

		public function get nameLabel() : GLabel {
			return _nameLabel;
		}

		public function get valueLabel() : GLabel {
			return _valueLabel;
		}
	}
}
