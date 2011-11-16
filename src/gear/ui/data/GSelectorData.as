package gear.ui.data {
	import gear.net.AssetData;
	import gear.ui.controls.GLabel;
	import gear.ui.core.GAlign;
	import gear.ui.core.GBaseData;
	/**
	 * 选择器控件定义
	 * 
	 * @author bright
	 * @version 20101018
	 */
	public class GSelectorData extends GBaseData {
		public var prev_buttonData : GButtonData;
		public var next_buttonData : GButtonData;
		public var labelData : GLabelData;
		public var content : Class;
		public var componentData : GBaseData;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GSelectorData = source as GSelectorData;
			if (data == null) {
				return;
			}
			data.prev_buttonData = prev_buttonData.clone();
			data.next_buttonData = next_buttonData.clone();
			data.labelData = labelData;
			data.content = content;
			data.componentData = componentData.clone();
		}

		public function GSelectorData() {
			prev_buttonData = new GButtonData();
			prev_buttonData.labelData.iconData.asset = new AssetData("GSelector_prevIcon");
			prev_buttonData.width = 19;
			prev_buttonData.height = 19;
			next_buttonData = new GButtonData();
			next_buttonData.labelData.iconData.asset = new AssetData("GSelector_nextIcon");
			next_buttonData.align = new GAlign(-1, 0, -1, -1, -1, 0);
			next_buttonData.width = 19;
			next_buttonData.height = 19;
			labelData = new GLabelData();
			content = GLabel;
			componentData = new GLabelData();
			width = 80;
			height = 20;
		}

		override public function clone() : * {
			var data : GSelectorData = new GSelectorData();
			parse(data);
			return data;
		}
	}
}
