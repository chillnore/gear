package gear.ui.controls {
	import gear.ui.core.GAlign;
	import gear.ui.core.GBase;
	import gear.ui.data.GSelectorData;
	import gear.ui.layout.GLayout;
	import gear.ui.model.GListEvent;
	import gear.ui.model.ListModel;
	import gear.ui.model.ListState;
	import gear.ui.model.SingleSelectionModel;

	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * GSelector 选择器控件
	 * 
	 * @author bright
	 * @version 20110628
	 */
	public class GSelector extends GBase {
		/**
		 * @private
		 */
		protected var _data : GSelectorData;
		/**
		 * @private
		 */
		protected var _label : GLabel;
		/**
		 * @private
		 */
		protected var _prev_btn : GButton;
		/**
		 * @private
		 */
		protected var _next_btn : GButton;
		/**
		 * @private
		 */
		protected var _content : GBase;
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
			var left : int = 0;
			if (_data.labelData != null) {
				_data.labelData.align = new GAlign(-1, -1, -1, -1, -1, 0);
				_label = new GLabel(_data.labelData);
				left = _label.width;
				addChild(_label);
			}
			_data.prev_buttonData.align = new GAlign(left, -1, -1, -1, -1, 0);
			addButtons();
			addContent();
		}

		private function addButtons() : void {
			_prev_btn = new GButton(_data.prev_buttonData);
			addChild(_prev_btn);
			_next_btn = new GButton(_data.next_buttonData);
			addChild(_next_btn);
		}

		private function addContent() : void {
			_content = new _data.content(_data.componentData);
			addChild(_content);
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			if (_label != null) {
				GLayout.layout(_label);
			}
			GLayout.layout(_prev_btn);
			GLayout.layout(_next_btn);
			layoutContent();
		}

		private function layoutContent() : void {
			var labelWidth : int = (_label ? _label.width : 0);
			_content.x = labelWidth + Math.floor((_width - labelWidth - _content.width) / 2);
			_content.y = Math.floor((_height - _content.height) / 2);
		}

		private function prevHandler(event : Event) : void {
			if (_selectionModel.index > 0) {
				_selectionModel.index--;
			} else {
				_selectionModel.index = _model.size - 1;
			}
		}

		private function nextHandler(event : Event) : void {
			if (_selectionModel.index < _model.size - 1) {
				_selectionModel.index++;
			} else {
				_selectionModel.index = 0;
			}
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
			switch(event.state) {
				case ListState.RESET:
					if (_selectionModel.index >= _model.size || _selectionModel.index == -1) {
						_selectionModel.index = 0;
					}
					reset();
					break;
				case ListState.ADDED:
					break;
				case ListState.REMOVED:
					if (event.index < _selectionModel.index || event.index == _selectionModel.index) {
						_selectionModel.index -= 1;
					}
					if (_selectionModel.index == -1) {
						_selectionModel.index = 0;
					}
					reset();
					break;
				case ListState.UPDATE:
					break;
				case ListState.INSERT:
					if (event.index <= _selectionModel.index) {
						_selectionModel.index += 1;
					}
					if (_selectionModel.index == -1) {
						_selectionModel.index = 0;
					}
					reset();
					break;
			}
		}

		private function selection_changeHandler(event : Event) : void {
			reset();
		}

		private function reset() : void {
			_content.source = _model.getAt(_selectionModel.index);
			layoutContent();
		}

		/**
		 * @private
		 */
		override protected function onEnabled() : void {
			_prev_btn.enabled = _enabled;
			_next_btn.enabled = _enabled;
			_prev_btn.iconGray = !_enabled;
			_next_btn.iconGray = !_enabled;
		}

		/**
		 * @inheritDoc
		 */
		public function GSelector(data : GSelectorData) {
			_data = data;
			super(data);
			_prev_btn.addEventListener(MouseEvent.CLICK, prevHandler);
			_next_btn.addEventListener(MouseEvent.CLICK, nextHandler);
			_selectionModel = new SingleSelectionModel();
			_selectionModel.addEventListener(Event.CHANGE, selection_changeHandler);
			_model = new ListModel();
			addModelEvents();
		}

		/**
		 * @return 模型
		 * @see gear.ui.model.SelectionModel
		 */
		public function get selectionModel() : SingleSelectionModel {
			return _selectionModel;
		}

		/**
		 * @return 列表模型
		 * @see gear.ui.model.ListModel
		 */
		public function get model() : ListModel {
			return _model;
		}

		/**
		 * @return 选中对象
		 */
		public function get selection() : Object {
			return _model.getAt(_selectionModel.index);
		}
	}
}
