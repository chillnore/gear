package gear.net {
	import gear.data.GHashMap;
	import gear.gui.model.GRangeModel;

	/**
	 * 加载模型
	 * 
	 * @author bright
	 * @version 20121108
	 */
	public final class GLoadModel extends GRangeModel {
		protected var _list : GHashMap;

		protected function onModelChange() : void {
			_value = 0;
			_max = 0;
			for each (var model:GRangeModel in _list.values) {
				_value += model.value;
				_max += model.max;
			}
			update();
		}

		public function GLoadModel() {
			_list = new GHashMap();
		}

		public function reset(value : Vector.<AGLoader>) : void {
			setTo(0, 0, 100);
			_list.clear();
			for each (var loader:AGLoader in value) {
				_list.put(loader.key, loader.model);
				loader.model.onChange = onModelChange;
			}
		}
	}
}