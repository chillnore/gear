package gear.gui.controls {
	import gear.gui.core.GBase;
	import gear.gui.skin.IGSkin;
	import gear.gui.utils.GUIUtil;
	/**
	 * 进度条控件
	 * 
	 * @author bright
	 * @version 20121210
	 */
	public class GProgressBar extends GBase{
		public static const MANUAL : int = 0;
		public static const POLLED : int = 1;
		protected var _trackSkin:IGSkin;
		protected var _barSkin:IGSkin;
		protected var _mode:int;
		protected var _min:int;
		protected var _max:int;
		protected var _value:int;
		
		override protected function preinit():void{
			_trackSkin=GUIUtil.theme.progressBarTrackSkin;
			_barSkin=GUIUtil.theme.progressBarBarSkin;
			_min=0;
			_max=100;
			_value=0;
			setSize(120,8);
		}
		
		override protected function create():void{
			_trackSkin.addTo(this,0);
			_barSkin.addTo(this,1);
		}
		
		override protected function resize():void{
			_trackSkin.setSize(_width,_height);
			updateBar();
		}
		
		protected function updateBar():void{
			_barSkin.setSize((_value-_min)/(_max-_min)*_width,_height);
		}
		
		public function GProgressBar(){
		}
	}
}
