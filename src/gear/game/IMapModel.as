package gear.game {
	/**
	 * @author admin
	 */
	public interface IMapModel {
		function canPass(startX : int, startY : int, endX : int, endY : int) : Boolean;
	}
}
