package gear.ui.data {
	import gear.ui.core.GBaseData;
	import gear.ui.manager.UIManager;
	import gear.ui.skin.ASSkin;
	import gear.ui.skin.SkinStyle;

	import flash.display.DisplayObject;

	/**
	 * @version 20091215
	 * @author bright
	 */
	public class GRadioButtonData extends GBaseData {
		public var upSkin : DisplayObject;
		public var upIcon : DisplayObject;
		public var selectedUpIcon : DisplayObject;
		public var labelData : GLabelData;
		public var selected : Boolean = false;
		public var padding : int = 2;
		public var hGap : int = 2;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GRadioButtonData = source as GRadioButtonData;
			if (data == null) {
				return;
			}
			data.upSkin = UIManager.cloneSkin(upSkin);
			data.upIcon = upIcon;
			data.selectedUpIcon = selectedUpIcon;
			data.labelData = labelData.clone();
			data.selected = selected;
			data.padding = padding;
			data.hGap = hGap;
		}

		public function GRadioButtonData() {
			upSkin = ASSkin.emptySkin;
			upIcon = UIManager.getSkinBy(SkinStyle.radioButton_upIcon, "ui");
			selectedUpIcon = UIManager.getSkinBy(SkinStyle.radioButton_selectedUpIcon, "ui");
			labelData = new GLabelData();
			width = 70;
			height = 18;
		}

		override public function clone() : * {
			var data : GRadioButtonData = new GRadioButtonData();
			parse(data);
			return data;
		}
	}
}
