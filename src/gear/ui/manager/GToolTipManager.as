package gear.ui.manager {
	import gear.ui.layout.GLayout;

	import flash.display.DisplayObject;
	import flash.events.MouseEvent;


	/**
	 * 提示框管理器
	 * 
	 * @author BrightLi
	 * @version 20101020
	 */
	public class GToolTipManager {
		private static function toolTip_rollOverHandler(event : MouseEvent) : void {
			var target : * = event.currentTarget;
			if (target != null && target.toolTip != null) {
				GLayout.layoutTip(target, target.toolTip, target.toolTip.data.alginMode, target.toolTip.data.alginHGap, target.toolTip.data.alginVGap, target.mouseX, target.mouseY);
				UIManager.root.addChild(target.toolTip);
			}
		}

		private static function toolTip_rollOutHandler(event : MouseEvent) : void {
			var target : * = event.currentTarget;
			if (target != null && target.toolTip != null) {
				target.toolTip.hide();
			}
		}

		private static function toolTip_mouseDownHandler(event : MouseEvent) : void {
			var target : * = event.currentTarget;
			if (target != null && target.toolTip != null) {
				target.toolTip.hide();
			}
		}

		private static function toolTip_mouseMoveHandler(event : MouseEvent) : void {
			var target : * = event.currentTarget;
			if (target != null && target.toolTip != null) {
				GLayout.layoutTip(target, target.toolTip, target.toolTip.data.alginMode, target.toolTip.data.alginHGap, target.toolTip.data.alginVGap, target.mouseX, target.mouseY);
				event.updateAfterEvent();
			}
		}

		/**
		 * 加入提示框控件
		 * @param value 组件
		 */
		public static function add(value : DisplayObject) : void {
			value.addEventListener(MouseEvent.ROLL_OVER, toolTip_rollOverHandler);
			value.addEventListener(MouseEvent.ROLL_OUT, toolTip_rollOutHandler);
			value.addEventListener(MouseEvent.MOUSE_DOWN, toolTip_mouseDownHandler);
			value.addEventListener(MouseEvent.MOUSE_MOVE, toolTip_mouseMoveHandler);
		}
	}
}