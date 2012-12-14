package gear.codec.swf.tags {
	import gear.codec.swf.GSwfStream;

	/**
	 * FileAttributes 文件属性
	 * 
	 * @author bright
	 * @version 20121120
	 */
	public class GTagFileAttributes implements IGSwfTag {
		public static const TYPE : int = 69;
		public var useDirectBlit : int;
		public var useGPU : int;
		public var hasMetaData : int;
		public var actionScript3 : int;
		public var useNetwork : int;

		public function GTagFileAttributes() {
		}

		public function decode(data : GSwfStream,length:uint) : void {
			var reserved : int = data.readUB(1);
			useDirectBlit = data.readUB(1);
			useGPU = data.readUB(1);
			hasMetaData = data.readUB(1);
			actionScript3 = data.readUB(1);
			useNetwork = data.readUB(1);
			reserved = data.readUB(24);
		}
	}
}
