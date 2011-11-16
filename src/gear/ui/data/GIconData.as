package gear.ui.data {
	import gear.net.AssetData;
	import gear.ui.core.GBaseData;
	import gear.ui.core.ScaleMode;

	import flash.display.BitmapData;


	/**
	 * 图标控件定义
	 * 
	 * @author bright
	 * @version 20101018
	 */
	public class GIconData extends GBaseData {
		/**
		 * 图标元件定义
		 */
		public var asset : AssetData;
		/**
		 * 位图
		 */
		public var bitmapData : BitmapData;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GIconData = source as GIconData;
			if(data == null) {
				return;
			}
			data.asset = asset;
			data.bitmapData = bitmapData;
		}

		public function GIconData() {
			scaleMode = ScaleMode.AUTO_SIZE;
		}

		override public function clone() : * {
			var data : GIconData = new GIconData();
			parse(data);
			return data;
		}
	}
}
