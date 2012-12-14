package gear.gui.controls {
	import gear.gui.core.GBase;
	import gear.gui.skin.IGSkin;
	/**
	 * 步进器控件
	 * 
	 * @author bright
	 */
	public class GStepper extends GBase{
		protected var _arrowUpSkin:IGSkin;
		protected var _arrowDownSkin:IGSkin;
		protected var _textInput:GTextInput;
		protected var _up_btn : GButton;
		protected var _down_btn : GButton;

		public function GStepper() {
		}
	}
}
