package gear.ui.manager {
	import gear.ui.controls.GToolTip;
	import gear.ui.core.GAlign;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.clearTimeout;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;

	/**
	 * 提示框管理器
	 * 
	 * @author BrightLi
	 * @version 20101020
	 */
	public class GToolTipManager {
		public static const LIFT:int = 0;
		public static const RIGHT:int = 1;
		public static var tipContainer:DisplayObjectContainer=UIManager.root;
		private static var token:uint;
		private static function toolTip_rollOverHandler(event : MouseEvent) : void {
			var target : * = event.currentTarget;
			showTip(target, false);
		}
		
		public static function showTip( target:*, underMouse:Boolean = false ):void
		{
			clearTimeout( token );
			token = setTimeout( function():void
			{
				var toolTip:GToolTip = target.toolTip;
				if (toolTip != null )
				{
					tipContainer.addChild( toolTip );
					var objBounds:Rectangle = target.getBounds( tipContainer );
					var bottomRight:Point = objBounds.bottomRight;
					if (underMouse)
					{
						toolTip.moveTo( tipContainer.mouseX, tipContainer.mouseY );
						var NativeCursor:Class = getDefinitionByName( "NativeCursor" ) as Class;
						if (NativeCursor.supportsNativeCursor)
						{
							toolTip.x += 32;
							toolTip.y += 32;
						}
						else
						{
							toolTip.x += 13;
							toolTip.y += 17;
						}
					}
					else
					{
						toolTip.x = bottomRight.x;
						toolTip.y = bottomRight.y;
						if (toolTip.align == GAlign.CENTER)
						{
							toolTip.x -= toolTip.width * .5 + target.width * .5;
						}
					}
					checkBound( toolTip, objBounds );
					//trace( "checkBound:" + toolTip.x, toolTip.y,toolTip.width,toolTip.height,toolTip.source,toolTip.visible,toolTip.alpha );
				}
				clearTimeout( token );
			}, 100 );
		}
		
		private static function checkBound( toolTip:DisplayObject, targetBounds:Rectangle ):void
		{
			var leftBound:int = 0;
			var rightBound:int = UIManager.root.stage.stageWidth;
			var bottomBound:int = UIManager.root.stage.stageHeight;
			var toolTipBounds:Rectangle = toolTip.getBounds( tipContainer );
			if (toolTipBounds.left < 0)
			{
				toolTip.x = leftBound;
			}
			else if (toolTipBounds.right > rightBound)
			{
				toolTip.x = targetBounds.left - toolTip.width;
			}
			if (toolTipBounds.bottom > bottomBound)
			{
				toolTip.y = targetBounds.top - toolTip.height;
				var currentBounds:Rectangle = toolTip.getBounds( tipContainer );
				if (currentBounds.top < 0)
				{
					toolTip.y = (targetBounds.height - toolTip.height) / 2 + targetBounds.y;
					currentBounds = toolTip.getBounds( tipContainer );
					if (currentBounds.top < 0)
					{
						toolTip.y = (bottomBound - toolTip.height) / 2;
					}
				}
			}
			else if (toolTipBounds.y > bottomBound)
			{
				toolTip.x = bottomBound;
			}
		}

		private static function toolTip_rollOutHandler(event : MouseEvent) : void {
			clearTimeout( token );
			var target : * = event.currentTarget;
			if (target != null && target.toolTip != null) {
				target.toolTip.hide();
			}
		}

		private static function toolTip_mouseDownHandler(event : MouseEvent) : void {
			clearTimeout( token );
			var target : * = event.currentTarget;
			if (target != null && target.toolTip != null) {
				target.toolTip.hide();
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
		}
	}
}