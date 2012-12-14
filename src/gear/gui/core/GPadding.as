package gear.gui.core {
	/**
	 * 内边距
	 * 
	 * @author bright
	 * @version 20121205
	 */
	public final class GPadding {
		public var left:int;
		public var right:int;
		public var top:int;
		public var bottom:int;
		
		public function GPadding(){
		}
		
		public function set dist(value:int):void{
			left=right=top=bottom=value;
		}
		
		public function set hdist(value:int):void{
			left=right=value;
		}
		
		public function set vdist(value:int):void{
			top=bottom=value;
		}
	}
}
