package gear.game.path {
	/**
	 * 地图碰撞
	 * 
	 * @author bright
	 * @version 20111205
	 */
	public interface IGMap {
		function isOut(x:int,y:int):Boolean;
		function walkable(source:GNode,target:GNode) : Boolean;
	}
}
