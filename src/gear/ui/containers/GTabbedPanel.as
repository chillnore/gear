package gear.ui.containers {
	import gear.ui.controls.GToggleButton;
	import gear.ui.core.GBase;
	import gear.ui.data.GTabbedPanelData;
	import gear.ui.data.GToggleButtonData;
	import gear.ui.group.GToggleGroup;

	import flash.events.Event;

	/**
	 * 选项面板控件
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class GTabbedPanel extends GBase {
		/**
		 * @private
		 */
		protected var _data : GTabbedPanelData;
		/**
		 * @private
		 */
		protected var _group : GToggleGroup;
		/**
		 * @private
		 */
		protected var _viewStack : GViewStack;

		/**
		 * @private
		 */
		override protected function create() : void {
			_group = new GToggleGroup();
			_viewStack = new GViewStack(_data.viewStackData);
			addChild(_viewStack);
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			_viewStack.x = 0;
			_viewStack.y = _data.tabData.height - 1;
		}

		private function initEvents() : void {
			_group.selectionModel.addEventListener(Event.CHANGE, group_changeHandler);
		}

		private function group_changeHandler(event : Event) : void {
			_viewStack.selectionModel.index = _group.selectionModel.index;
			_width = _viewStack.width;
			_height = _data.tabData.height + _viewStack.height - 1;
		}

		/**
		 * @inheritDoc
		 */
		public function GTabbedPanel(data : GTabbedPanelData) {
			_data = data;
			super(_data);
			initEvents();
		}

		/**
		 * 获得选中的选项控件
		 * 
		 * @return 控件
		 */
		public function get selection() : GBase {
			return _viewStack.selection;
		}

		/**
		 * 获得选项组
		 * 
		 * @return 选项组
		 */
		public function get group() : GToggleGroup {
			return _group;
		}

		/**
		 * 加入选项
		 * 
		 * @param title 选项标题
		 * @param component 选项控件
		 */
		public function addTab(title : String, component : GBase) : void {
			var tab : GToggleButton = new GToggleButton(_data.tabData);
			tab.text = title;
			var lastTab : GToggleButton = GToggleButton(_group.model.getLast());
			if (lastTab) {
				tab.x = lastTab.x + lastTab.width - 1;
				tab.y = 0;
			}
			addChild(tab);
			_group.model.add(tab);
			_viewStack.add(component);
			if (_group.selectionModel.index == -1) {
				_group.selectionModel.index = 0;
			}
		}

		public function addIconTab(data : GToggleButtonData, component : GBase) : void {
			var tab : GToggleButton = new GToggleButton(data);
			var lastTab : GToggleButton = GToggleButton(_group.model.getLast());
			if (lastTab) {
				tab.x = lastTab.x + lastTab.width - 1;
				tab.y = 0;
			}
			addChild(tab);
			_group.model.add(tab);
			_viewStack.add(component);
			if (_group.selectionModel.index == -1) {
				_group.selectionModel.index = 0;
			}
		}
	}
}
