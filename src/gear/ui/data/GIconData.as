package gear.ui.data {
	import gear.ui.core.GBaseData;
	import gear.ui.core.GScaleMode;

	import flash.display.BitmapData;

	/**
	 * 图标控件定义
	 * 
	 * @author bright
	 * @version 20120815
	 */
	public class GIconData extends GBaseData {
		/**
		 * 位图
		 */
		public var bitmapData : BitmapData;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GIconData = source as GIconData;
			if (data == null) {
				return;
			}
			data.bitmapData = bitmapData;
		}

		public function GIconData() {
			scaleMode = GScaleMode.AUTO_SIZE;
		}

		override public function clone() : * {
			var data : GIconData = new GIconData();
			parse(data);
			return data;
		}
	}
}
