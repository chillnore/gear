package gear.game.path {
	/**
	 * 地图碰撞
	 * 
	 * @author bright
	 * @version 20111205
	 */
	public interface IMapHit {
		function canPass(halfW : int, halfH : int, startX : int, startY : int, endX : int, endY : int) : Boolean;
	}
}
