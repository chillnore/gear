package gear.game.path {
	import flash.utils.ByteArray;

	/**
	 * 每2位存储一个标识,每字节存储4个标识
	 * 0 通路
	 * 1 障碍
	 * 2 透明
	 * 3 保留
	 * 
	 * @author bright
	 * @version 20130105
	 */
	public class GMapBlock {
		protected var _gw : int;
		protected var _gh : int;
		protected var _tw : int;
		protected var _th : int;
		protected var _blocks : ByteArray;

		public function GMapBlock() {
			_blocks = new ByteArray();
		}

		public function setTo(gw : int, gh : int, tw : int, th : int) : void {
			_gw = gw;
			_gh = gh;
			_tw = tw;
			_th = th;
			_blocks.length = (_gw * _gh) >> 2;
		}

		public function setBlock(x : int, y : int, isBlock : Boolean) : void {
			var index : int = y * _gw + x;
			var bits : int = (3 - index % 4) << 1;
			var sign : int = isBlock ? 1 << bits : 0;
			var offset : int = index >> 2;
			var byte : int = _blocks[offset] & ~(3 << bits) | sign;
			_blocks[offset] = byte;
		}

		public function walkable(x : int, y : int) : Boolean {
			var index : int = y * _gw + x;
			var bits : int = (3 - index % 4) << 1;
			var byte : int = _blocks[index >> 2];
			var sign : int = byte >> bits & 3;
			return sign != 1;
		}

		public function clear() : void {
			_blocks.clear();
		}

		public function get gw() : int {
			return _gw;
		}

		public function get gh() : int {
			return _gh;
		}

		public function get tw() : int {
			return _tw;
		}

		public function get th() : int {
			return _th;
		}

		public function toObject() : Object {
			var result : Object = new Object();
			result.gw = _gw;
			result.gh = _gh;
			result.tw = _tw;
			result.th = _th;
			result.blocks = _blocks;
			return result;
		}

		public function parseObj(value : Object) : void {
			_gw = value.gw;
			_gh = value.gh;
			_tw = value.tw;
			_th = value.th;
			_blocks = value.blocks;
		}
	}
}
