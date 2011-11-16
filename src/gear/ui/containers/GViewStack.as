package gear.ui.containers {
	import gear.ui.core.GBase;
	import gear.ui.core.GBaseData;
	import gear.ui.model.GListEvent;
	import gear.ui.model.ListModel;
	import gear.ui.model.ListState;
	import gear.ui.model.SingleSelectionModel;

	import flash.events.Event;

	/**
	 * 视图堆控件
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class GViewStack extends GBase {
		/**
		 * @private
		 */
		protected var _selection : GBase;
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
					if (_selectionModel.index >= _model.size) {
						_selectionModel.index = 0;
					}
					updateContent();
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
					updateContent();
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
			if (_selection)
				_selection.parent.removeChild(_selection);
			var component : GBase = _model.getAt(_selectionModel.index) as GBase;
			if (component) {
				addChild(component);
				_width = component.width;
				_height = component.height;
			}
			_selection = component;
		}

		/**
		 * @inheritDoc
		 */
		public function GViewStack(base : GBaseData) {
			super(base);
			_selectionModel = new SingleSelectionModel();
			_model = new ListModel();
			addModelEvents();
			_selectionModel.addEventListener(Event.CHANGE, selection_changeHandler);
		}

		/**
		 * 获得单选模型
		 * 
		 * @return 单选模型
		 */
		public function get selectionModel() : SingleSelectionModel {
			return _selectionModel;
		}

		/**
		 * 获得选中的视图控件
		 * 
		 * @return 选中的视图控件
		 */
		public function get selection() : GBase {
			return _model.getAt(_selectionModel.index) as GBase;
		}

		/**
		 * 加入视图控件
		 * 
		 * @param component 控件
		 */
		public function add(component : GBase) : void {
			_model.add(component);
		}
	}
}