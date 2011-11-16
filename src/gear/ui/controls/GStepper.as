package gear.ui.controls {
	import gear.ui.core.GBase;
	import gear.ui.data.GStepperData;
	import gear.ui.model.RangeModel;

	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;

	/**
	 * 步进器控件
	 * 
	 * @author BrightLi
	 * @version 20101012
	 */
	public class GStepper extends GBase {
		/**
		 * @private
		 */
		protected var _data : GStepperData;
		/**
		 * @private
		 */
		protected var _upArrow : GButton;
		/**
		 * @private
		 */
		protected var _downArrow : GButton;
		/**
		 * @private
		 */
		protected var _textInput : GTextInput;
		/**
		 * @private
		 */
		protected var _model : RangeModel;

		/**
		 * @private
		 */
		override protected function create() : void {
			_upArrow = new GButton(_data.upArrowData);
			_downArrow = new GButton(_data.downArrowData);
			_downArrow.y = _upArrow.height;
			_textInput = new GTextInput(_data.textInputData);
			addChild(_upArrow);
			addChild(_downArrow);
			addChild(_textInput);
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			_upArrow.x = _width - _upArrow.width;
			_downArrow.x = _width - _downArrow.width;
			_textInput.width = _width - _upArrow.width;
		}

		/**
		 * @private
		 */
		protected function addModelEvents() : void {
			_model.addEventListener(Event.CHANGE, model_changeHandler);
		}

		/**
		 * @private
		 */
		protected function removeModelEvents() : void {
			_model.removeEventListener(Event.CHANGE, model_changeHandler);
		}

		/**
		 * @private
		 */
		protected function model_changeHandler(event : Event) : void {
			_textInput.text = String(_model.value);
		}

		/**
		 * @private
		 */
		protected function initEvents() : void {
			_textInput.addEventListener(GTextInput.ENTER, enterHandler);
			_textInput.addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
			_upArrow.addEventListener(MouseEvent.CLICK, up_clickHandler);
			_downArrow.addEventListener(MouseEvent.CLICK, down_clickHandler);
			addModelEvents();
		}

		/**
		 * @private
		 */
		protected function enterHandler(event : Event) : void {
			var value : Number = Number(_textInput.text);
			if (isNaN(Number(value))) {
				_textInput.text = String(_model.value);
			} else {
				_model.value = value;
			}
		}

		/**
		 * @private
		 */
		protected function focusOutHandler(event : Event) : void {
			var value : Number = Number(_textInput.text);
			if (isNaN(Number(value))) {
				_textInput.text = String(_model.value);
			} else {
				_model.value = value;
			}
		}

		/**
		 * @private
		 */
		protected function up_clickHandler(event : MouseEvent) : void {
			if (_model.value < _model.max) {
				_model.value++;
			}
		}

		/**
		 * @private
		 */
		protected function down_clickHandler(event : MouseEvent) : void {
			if (_model.value > _model.min) {
				_model.value--
				;
			}
		}

		/**
		 * @inheritDoc
		 */
		public function GStepper(data : GStepperData) {
			_data = data;
			super(_data);
			_model = new RangeModel();
			_textInput.text = String(_model.value);
			initEvents();
		}

		/**
		 * 设置范围模型
		 * 
		 * @param 范围模型
		 */
		public function set model(value : RangeModel) : void {
			if (_model === value) {
				return;
			}
			if (_model != null) {
				removeModelEvents();
			}
			_model = value;
			_textInput.text = String(_model.value);
			addModelEvents();
		}

		/**
		 * 获得范围模型
		 * 
		 * @return 范围模型
		 */
		public function get model() : RangeModel {
			return _model;
		}
	}
}
