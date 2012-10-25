package gear.ui.controls {
	import flash.geom.Rectangle;

	import gear.ui.data.GRectToolData;
	import gear.ui.core.GBase;

	/**
	 * 变形工具
	 * 
	 * @author bright
	 * @version 20120416
	 */
	public class GRectTool extends GBase {
		protected var _data : GRectToolData;
		protected var _target : Rectangle;

		override protected function create() : void {
		}

		override protected function layout() : void {
		}

		public function GRectTool(data : GRectToolData) {
			_data = data;
			super(_data);
		}

		public function set target(value : Rectangle) : void {
			_target = value;
		}
	}
}
