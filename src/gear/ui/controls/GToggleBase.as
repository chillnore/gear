package gear.ui.controls {
	import gear.ui.core.GBase;
	import gear.ui.core.GBaseData;
	import gear.ui.group.GToggleGroup;

	/**
	 * 双模基础控件
	 * 
	 * @author bright
	 * @version 20101018
	 */
	public class GToggleBase extends GBase {
		/**
		 * @private
		 */
		protected var _selected : Boolean = false;
		/**
		 * @private
		 */
		protected var _group : GToggleGroup;

		/**
		 * @private
		 */
		protected function onSelect() : void {
			// this is abstract function
		}

		/**
		 * @inheritDoc
		 */
		public function GToggleBase(data : GBaseData) {
			super(data);
		}

		/**
		 * 设置选中状态
		 * 
		 * @param value 是否选中
		 */
		public function set selected(value : Boolean) : void {
			if (_selected == value) {
				return;
			}
			_selected = value;
			if (_group != null && _selected) {
				_group.isSelected(this);
			}
			onSelect();
		}

		/**
		 * 获得选中状态
		 * 
		 * @return 是否选中
		 */
		public function get selected() : Boolean {
			return _selected;
		}

		/**
		 * 设置组
		 * 
		 * @param value 双模组
		 */
		public function set group(value : GToggleGroup) : void {
			_group = value;
		}
	}
}