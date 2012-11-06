package gear.ui.containers {
	import avmplus.getQualifiedClassName;

	import gear.ui.core.GBase;
	import gear.ui.data.GTitleWindowData;
	import gear.ui.manager.GUIUtil;
	import gear.ui.manager.ViewManage;
	import gear.ui.skin.ASSkin;
	import gear.utils.GMathUtil;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * 标题窗口控件
	 * 
	 * @author bright
	 * @version 201015
	 */
	public class GTitleWindow extends GBase {
		/**
		 * @private
		 */
		protected var _data : GTitleWindowData;
		/**
		 * @private
		 */
		protected var _titleBar : GTitleBar;
		/**
		 * @private
		 */
		protected var _contentPanel : GPanel;
		/**
		 * @private
		 */
		protected var _modalSkin : Sprite;
		/**
		 * @private
		 */
		protected var _regX : int;
		/**
		 * @private
		 */
		protected var _regY : int;

		/**
		 * @private
		 */
		override protected function create() : void {
			_titleBar = new GTitleBar(_data.titleBarData);
			_contentPanel = new GPanel(_data.panelData);
			_contentPanel.y = _titleBar.height - 1;
			addChild(_contentPanel);
			addChild(_titleBar);
			if (_data.modal) {
				_modalSkin = ASSkin.modalSkin;
			}
			addCloseButton();
			name=getQualifiedClassName(this);
		}

		protected function addCloseButton() : void {
			if (_titleBar.close_Btn != null) {
				_titleBar.close_Btn.addEventListener(MouseEvent.CLICK, cloesButton_handler);
			}
		}

		protected function cloesButton_handler(event : MouseEvent) : void {
			dispatchEvent(new Event(Event.CLOSE));
			hide();
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			_titleBar.width = _width;
			_contentPanel.setSize(_width, _height - _titleBar.height - 1);
		}

		/**
		 * @private
		 */
		override protected function onShow() : void {
			if (_data.modal) {
				var topLeft : Point = parent.localToGlobal(GMathUtil.ZERO_POINT);
				_modalSkin.x = -topLeft.x;
				_modalSkin.y = -topLeft.y;
				_modalSkin.width = GUIUtil.root.stage.stageWidth;
				_modalSkin.height = GUIUtil.root.stage.stageHeight;
				parent.addChildAt(_modalSkin, parent.numChildren - 1);
				parent.swapChildrenAt(parent.getChildIndex(this), parent.numChildren - 1);
			}
			if (_data.allowDrag) {
				_titleBar.addEventListener(MouseEvent.MOUSE_DOWN, titleBar_mouseDownHandler);
			}
			
		}

		override public function show() : void {
			super.show();
			if (name.indexOf("View") != -1&&parent==GUIUtil.root) {
				ViewManage.add(this);
			}
		}
		/**
		 * @private
		 */
		override protected function onHide() : void {
			if (_data.modal) {
				_modalSkin.parent.removeChild(_modalSkin);
			}
			if (_data.allowDrag) {
				_titleBar.removeEventListener(MouseEvent.MOUSE_DOWN, titleBar_mouseDownHandler);
				if (stage.hasEventListener(MouseEvent.MOUSE_MOVE)) {
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
				}
				if (stage.hasEventListener(MouseEvent.MOUSE_UP)) {
					stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
				}
			}
			if (name.indexOf("View") != -1) {
				ViewManage.remove(this);
			}
		}

		private function titleBar_mouseDownHandler(event : MouseEvent) : void {
			startDragging(event);
		}

		private function startDragging(event : MouseEvent) : void {
			_regX = event.stageX - x;
			_regY = event.stageY - y;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
		}

		private function stage_mouseMoveHandler(event : MouseEvent) : void {
			if (isNaN(_regX) || isNaN(_regY))
				return;
			var newX : int = Math.min(stage.stageWidth - _width, event.stageX - _regX);
			var newY : int = Math.min(stage.stageHeight - _height, event.stageY - _regY);
			moveTo(newX, newY);
		}

		private function stage_mouseUpHandler(event : MouseEvent) : void {
			if (!isNaN(_regX))
				stopDragging();
		}

		private function stopDragging() : void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
			_regX = NaN;
			_regY = NaN;
		}

		/**
		 * @inheritDoc
		 */
		public function GTitleWindow(data : GTitleWindowData) {
			_data = data;
			super(data);
		}

		/**
		 * 获得内容面板控件
		 * 
		 * @return 内容面板控件
		 */
		public function get contentPanel() : GPanel {
			return _contentPanel;
		}

		/**
		 * 获得是否为模式窗口
		 * 
		 * @return 是否为模式窗口
		 */
		public function get modal() : Boolean {
			return _data.modal;
		}

		/**
		 * @private
		 * 重置模式皮肤
		 */
		public function resizeModal() : void {
			if (_modalSkin == null) {
				return;
			}
			_modalSkin.width = GUIUtil.root.stage.stageWidth;
			_modalSkin.height = GUIUtil.root.stage.stageHeight;
		}
	}
}