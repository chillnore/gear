package gear.game {
	/**
	 * @author admin
	 */
	public class MapModel implements IMapModel {
		private var _list : Array;

		public function MapModel() {
			_list = [0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0];
		}

		public function canPass(startX : int, startY : int, endX : int, endY : int) : Boolean {
			if (startX < 0 || startY < 0 || endX < 0 || endY < 0) {
				return false;
			}
			if (_list[startX + startY * 5] == 1) {
				return false;
			}
			return true;
		}
	}
}
