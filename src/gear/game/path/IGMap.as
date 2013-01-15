package gear.game.path {
	import gear.game.hit.GBlock;

	/**
	 * 地图接口
	 * 
	 * @author bright
	 * @version 20130107
	 */
	public interface IGMap {
		function isHitOrOut(block : GBlock) : Boolean;

		function isOut(block : GBlock, nodeX : int, nodeY : int) : Boolean;

		function walkable(block : GBlock, source : GNode, target : GNode) : Boolean;
	}
}
