package gear.ui.controls {
	import gear.ui.core.GBase;
	import gear.ui.data.GSpinnerData;
	import gear.ui.model.GListEvent;
	import gear.ui.model.ListModel;
	import gear.ui.model.ListState;
	import gear.ui.model.SingleSelectionModel;

	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * 选项器控件
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class GSpinner extends GBase {
		/**
		 * @private
		 */
		protected var _data : GSpinnerData;
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
		protected var _selectionModel : SingleSelectionModel;
		/**
		 * @private
		 */
		protected var _model : ListModel;

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
			_model.addEventListener(GListEvent.CHANGE, model_changeHandler);
		}

		/**
		 * @private
		 */
		protected function removeModelEvents() : void {
			_model.removeEventListener(GListEvent.CHANGE, model_changeHandler);
		}

		/**
		 * @private
		 */
		protected function model_changeHandler(event : GListEvent) : void {
			var index : int = event.index;
			switch(event.type) {
				case ListState.RESET:
					if (_selectionModel.index >= _model.size) {
						_selectionModel.index = 0;
					}
					updateContent();
					break;
				case ListState.ADDED:
					break;
				case ListState.REMOVED:
					if (index < _selectionModel.index) {
						_selectionModel.index -= 1;
					} else if (index == _selectionModel.index) {
						_selectionModel.index = -1;
					}
					if (_selectionModel.index == -1) {
						_selectionModel.index = 0;
					}
					updateContent();
					break;
				case ListState.UPDATE:
					break;
				case ListState.INSERT:
					if (index <= _selectionModel.index) {
						_selectionModel.index += 1;
					}
					if (_selectionModel.index == -1) {
						_selectionModel.index = 0;
					}
					updateContent();
					break;
			}
		}

		private function selection_changeHandler(event : Event) : void {
			updateContent();
		}

		/**
		 * @private
		 */
		protected function updateContent() : void {
			var value : Object = _model.getAt(_selectionModel.index);
			if (value) {
				_textInput.text = value.toString();
			} else {
				_textInput.clear();
			}
		}

		/**
		 * @private
		 */
		protected function initEvents() : void {
			_upArrow.addEventListener(MouseEvent.CLICK, up_clickHandler);
			_downArrow.addEventListener(MouseEvent.CLICK, down_clickHandler);
			addModelEvents();
			_selectionModel.addEventListener(Event.CHANGE, selection_changeHandler);
		}

		/**
		 * @private
		 */
		protected function up_clickHandler(event : MouseEvent) : void {
			if (_selectionModel.index < _model.size - 1) {
				_selectionModel.index++;
			}
		}

		/**
		 * @private
		 */
		protected function down_clickHandler(event : MouseEvent) : void {
			if (_selectionModel.index > 0) {
				_selectionModel.index--;
			}
		}

		public function GSpinner(data : GSpinnerData) {
			_data = data;
			super(_data);
			_selectionModel = new SingleSelectionModel();
			_model = new ListModel();
			initEvents();
		}

		public function get selectionModel() : SingleSelectionModel {
			return _selectionModel;
		}

		public function set selectionModel(value : SingleSelectionModel) : void {
			if (_selectionModel == value) {
				return;
			}
			if (_selectionModel) {
				_selectionModel.removeEventListener(Event.CHANGE, selection_changeHandler);
			}
			_selectionModel = value;
			_selectionModel.addEventListener(Event.CHANGE, selection_changeHandler);
			updateContent();
		}

		public function set model(value : ListModel) : void {
			if (_model === value)
				return;
			if (_model)
				removeModelEvents();
			_model = value;
			addModelEvents();
			updateContent();
		}
	}
}
