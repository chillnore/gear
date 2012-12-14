package gear.gui.core {
	/**
	 * @author bright
	 * @version 20121205
	 */
	public final class GPhaseColor {
		private var _colors:Vector.<uint>;
		
		public function GPhaseColor(){
			_colors=new Vector.<uint>(8);
		}
		
		public function setAt(phase:int,color:uint):void{
			_colors[phase]=color;
		}
		
		public function getBy(phase:int):uint{
			return _colors[phase];
		}
	}
}
