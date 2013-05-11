package gear.gui.model {
	import gear.data.GTreeNode;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * @author Administrator
	 */
	public class GDPTreeNode extends GTreeNode {
		protected var _firstTime : Boolean;

		public function GDPTreeNode(value : DisplayObject) {
			super(value);
			_firstTime = true;
		}

		override public function async() : void {
			if (_firstTime) {
				_firstTime = false;
				var node : GDPTreeNode;
				if (_data is DisplayObjectContainer) {
					for (var i : int = 0; i < DisplayObjectContainer(_data).numChildren; i++) {
						node = new GDPTreeNode(DisplayObjectContainer(_data).getChildAt(i));
						node.parent = this;
						_children.push(node);
					}
				}
			}
		}
	}
}
