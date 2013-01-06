package gear.game.path{
	import gear.data.GBinaryHeap;
	public class GDStar{
		protected var _openList:GBinaryHeap;
		protected var _start:GNode;
		protected var _goal:GNode;
		
		protected function compareNode(source : GNode, target : GNode) : int {
			return source.f - target.f;
		}
		
		public function GDStar(){
			_openList=new GBinaryHeap(compareNode);
		}
		
		public function replan():Boolean{
			while(!_start.equal(_goal)){
			}
			return true;
		}
	}
}