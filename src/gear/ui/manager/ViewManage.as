package gear.ui.manager {
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;

	import gear.ui.core.GBase;

	/**
	 * @author Cafe
	 * @version 20120228
	 */
	public class ViewManage {
		private static var _viewList : Vector.<GBase>=new Vector.<GBase>();
		private static var _top : DisplayObject;

		public static function add(value : GBase) : void {
			if (value == null) return;
			value.addEventListener(MouseEvent.CLICK, viewClickHandler);
			value.addEventListener(Event.REMOVED_FROM_STAGE, removeStageHandler);
			
			_viewList.push(value);
			_top = value;
		}

		private static function removeStageHandler(event : Event) : void {
			event.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, removeStageHandler);
			event.currentTarget.removeEventListener(MouseEvent.CLICK, viewClickHandler);
			_viewList.splice(_viewList.indexOf(event.currentTarget), 1);
		}

		private static function viewClickHandler(event : MouseEvent) : void {
			var obj : DisplayObject = event.currentTarget as DisplayObject;
			if (obj && _top && _top != obj) {
				obj.parent.swapChildren(obj, _top);
				_top = obj;
			}
		}

		public static function remove(value : GBase = null) : Boolean {
			if (value == null) {
				if (_viewList.length == 0) return false;
				_viewList[_viewList.length - 1].removeEventListener(MouseEvent.CLICK, viewClickHandler);
				_viewList[_viewList.length - 1].hide();
				return true;
			} else {
				value.removeEventListener(MouseEvent.CLICK, viewClickHandler);
				_viewList.splice(_viewList.indexOf(value), 1);
				return true;
			}
		}

		public static function getTopView() : GBase {
			return _top as GBase;
		}
	}
}
