package gear.codec.gif {
	import gear.log4a.GLogger;

	import flash.utils.ByteArray;

	/**
	 * @author Administrator
	 */
	public class GImageDescriptor {
		// 图像左坐标
		public var offsetLeft : int;
		// 图像顶坐标
		public var offsetTop : int;
		// 图像宽度
		public var width : int;
		// 图像高度
		public var height : int;
		public var packed : int;
		// 局部色表标志
		public var lct : int;
		// 隔行处理标志
		public var interlaced : int;
		// 短标志
		public var lctSorted : int;
		// 保留
		public var reserved : int;
		// 局部色表尺寸
		public var lctNumColors : int;

		public function GImageDescriptor() {
		}

		public function decode(value : ByteArray) : void {
			offsetLeft = value.readUnsignedShort();
			offsetTop = value.readUnsignedShort();
			width = value.readUnsignedShort();
			height = value.readUnsignedShort();
			packed = value.readUnsignedByte();
			lct = (packed & 0x80) >> 7;
			interlaced = (packed & 0x40) >> 6;
			lctSorted = (packed & 0x20) >> 5;
			reserved = (packed & 0x18) >> 3;
			lctNumColors = packed & 0x07;
			GLogger.debug("图像左坐标", offsetLeft, "图像顶坐标", offsetTop, "图像宽度", width, "图像高度", height, "局部色表标志", lct, "隔行处理标志", interlaced, "短标志", lctSorted, "保留", reserved, "局部色表尺寸", lctNumColors);
		}

		public function encode(value : ByteArray) : void {
			value.writeByte(0x2C);
			value.writeShort(offsetLeft);
			value.writeShort(offsetTop);
			value.writeShort(width);
			value.writeShort(height);
			packed = (lct & 0x01) << 7;
			packed |= (interlaced & 0x01) << 6;
			packed |= (lctSorted & 0x01) << 5;
			packed |= (reserved & 0x07) << 3;
			packed |= lctNumColors & 0x07;
			value.writeByte(packed);
		}
	}
}
