package gear.ui.data {
	import gear.ui.core.GAlign;
	import gear.ui.core.GBaseData;
	import gear.ui.core.GScaleMode;
	import gear.ui.manager.UIManager;

	import flash.display.DisplayObject;

	/**
	 * @author bright
	 */
	public class GTabData extends GBaseData {
		public var upSkin : DisplayObject;
		public var overSkin : DisplayObject;
		public var downSkin : DisplayObject;
		public var disabledSkin : DisplayObject;
		public var selectedUpSkin : DisplayObject;
		public var selectedDisabledSkin : DisplayObject;
		public var labelData : GLabelData;
		public var selected : Boolean = false;
		public var padding : int = 7;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GTabData = source as GTabData;
			if (data == null)
				return;
			data.upSkin = UIManager.cloneSkin(upSkin);
			data.selectedUpSkin = UIManager.cloneSkin(selectedUpSkin);
			data.labelData = (labelData ? labelData.clone() : null);
			data.selected = selected;
			data.padding = padding;
		}

		public function GTabData() {
			scaleMode = GScaleMode.AUTO_WIDTH;
			width = 60;
			height = 22;
			upSkin = UIManager.getSkinBy("GTab_upSkin", "ui");
			selectedUpSkin = UIManager.getSkinBy("GTab_selectedUpSkin", "ui");
			labelData = new GLabelData();
			labelData.color.upColor = 0xBEBEBE;
			labelData.color.overColor = 0xFFFFFF;
			labelData.color.selectedColor = 0xEFEFEF;
			labelData.align = new GAlign(-1, -1, -1, -1, 0, 0);
		}

		override public function clone() : * {
			var data : GTabData = new GTabData();
			parse(data);
			return data;
		}
	}
}
