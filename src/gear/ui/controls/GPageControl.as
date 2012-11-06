package gear.ui.controls {
	import gear.ui.core.GBase;
	import gear.ui.core.ScaleMode;
	import gear.ui.data.GPageControlData;
	import gear.ui.drag.DragData;
	import gear.ui.drag.DragState;
	import gear.ui.drag.IDragItem;
	import gear.ui.drag.IDragTarget;
	import gear.ui.layout.GLayout;
	import gear.ui.manager.UIManager;
	import gear.ui.model.PageModel;

	import flash.events.Event;
	import flash.events.MouseEvent;


	/**
	 * 翻页控制控件
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class GPageControl extends GBase implements IDragTarget {
		/**
		 * @private
		 */
		protected var _data : GPageControlData;
		/**
		 * @private
		 */
		protected var _prev_btn : GButton;
		/**
		 * @private
		 */
		protected var _page_lb : GLabel;
		/**
		 * @private
		 */
		protected var _next_btn : GButton;
		/**
		 * @private
		 */
		protected var _model : PageModel;

		/**
		 * @private
		 */
		override protected function create() : void {
			if (_data.bgSkin != null) {
				addChild(_data.bgSkin);
			}
			_prev_btn = new GButton(_data.prev_buttonData);
			_next_btn = new GButton(_data.next_buttonData);
			_page_lb = new GLabel(_data.labelData);
			addChild(_prev_btn);
			addChild(_next_btn);
			addChild(_page_lb);
			switch(_data.scaleMode) {
				case ScaleMode.WIDTH_ONLY:
					break;
				case ScaleMode.NONE:
					if (_data.bgSkin != null) {
						_width = _data.bgSkin.width;
						_height = _data.bgSkin.height;
					}
					break;
			}
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			GLayout.layout(_prev_btn);
			GLayout.layout(_page_lb);
			GLayout.layout(_next_btn);
		}

		private function pageModel_pageChangeHandler(event : Event) : void {
			reset();
		}

		private function pageModel_totalChangeHandler(event : Event) : void {
			reset();
		}

		private function reset() : void {
			_page_lb.text = _model.currentPage + "/" + _model.totalPage;
			GLayout.layout(_page_lb);
			_prev_btn.enabled = _model.hasPrevPage;
			_next_btn.enabled = _model.hasNextPage;
		}

		private function initView() : void {
			model = new PageModel();
		}

		private function initEvents() : void {
			_prev_btn.addEventListener(MouseEvent.CLICK, prev_clickHandler);
			_next_btn.addEventListener(MouseEvent.CLICK, next_clickHandler);
		}

		private function prev_clickHandler(event : Event) : void {
			_model.prevPage();
		}

		private function next_clickHandler(event : Event) : void {
			_model.nextPage();
		}

		/**
		 * @private
		 */
		public function GPageControl(data : GPageControlData) {
			_data = data;
			super(_data);
			initView();
			initEvents();
		}

		/**
		 * @param value PageModel 设置分页模型
		 */
		public function set model(value : PageModel) : void {
			if (_model != null) {
				_model.removeEventListener(PageModel.PAGE_CHANGE, pageModel_pageChangeHandler);
				_model.removeEventListener(PageModel.TOTAL_CHANGE, pageModel_totalChangeHandler);
			}
			_model = value;
			if (_model != null) {
				_model.addEventListener(PageModel.PAGE_CHANGE, pageModel_pageChangeHandler);
				_model.addEventListener(PageModel.TOTAL_CHANGE, pageModel_totalChangeHandler);
				reset();
			} else {
				_page_lb.text = "1/1";
				GLayout.layout(_page_lb);
				_prev_btn.enabled = _next_btn.enabled = false;
			}
		}

		/**
		 * @return PageModel 
		 */
		public function get model() : PageModel {
			return _model;
		}

		/**
		 * @return GLabel 标签
		 */
		public function get label() : GLabel {
			return _page_lb;
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		public function dragEnter(dragData : DragData) : Boolean {
			if (UIManager.atParent(dragData.hitTarget, _prev_btn)) {
				_model.prevPage();
				dragData.state = DragState.NEXT;
				return true;
			}
			if (UIManager.atParent(dragData.hitTarget, _next_btn)) {
				_model.nextPage();
				dragData.state = DragState.NEXT;
				return true;
			}
			return false;
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		public function canSwap(source : IDragItem, target : IDragItem) : Boolean {
			return true;
		}
	}
}