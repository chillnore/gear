package gear.game.path{
	public class GDStar{
		
		protected var _start:GNode;
		protected var _goal:GNode;
		
		protected function computeShortestPath():int{
			return -1;
		}
		
		public function GDStar(){
		}
		
		public function replan():Boolean{
			while(!_start.equal(_goal)){
			}
			return true;
		}
	}
}