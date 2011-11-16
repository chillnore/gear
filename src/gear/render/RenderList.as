package gear.render {
	import flash.display.BitmapData;

	/**
	 * RenderList
	 * 
	 * @author bright
	 * @version 20111024
	 */
	public class RenderList extends Render2C {
		protected var _list : Vector.<Render2C>;

		public function RenderList() : void {
			_list = new Vector.<Render2C>();
		}

		public function add(value : Render2C) : void {
			value.parent = this;
			_list.push(value);
		}

		public function remove(value : Render2C) : void {
			var index : int = _list.indexOf(value);
			if (index != -1) {
				_list.splice(index, 1);
				value.parent = null;
			}
		}

		override public function render(target : BitmapData, ox : int, oy : int) : void {
			for each (var render:Render2C in _list) {
				render.render(target, ox, oy);
			}
		}
	}
}
