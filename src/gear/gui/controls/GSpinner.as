package gear.gui.controls {
	import gear.gui.core.GBase;
	import gear.gui.skins.IGSkin;
	/**
	 * 选项器控件
	 * 
	 * @author bright
	 */
	public class GSpinner extends GBase{
		protected var _arrowUpSkin:IGSkin;
		protected var _arrowDownSkin:IGSkin;
		protected var _textInput:GTextInput;
		protected var _up_btn:GButton;
		protected var _down_btn:GButton;
		protected var _min:Number;
		protected var _max:Number;
		protected var _step:Number;
		
		public function GSpinner(){
			
		}
	}
}
