package gear.codec.gif {
	import flash.utils.ByteArray;

	/**
	 * 逻辑视屏描述-Logical Screen Descriptor
	 * 
	 * @author bright
	 */
	public class GLSD {
		// 逻辑屏幕宽
		public var width : int;
		// 逻辑屏幕高
		public var height : int;
		public var packed : uint;
		// 全局色表 1Bit
		public var gct : int;
		// 颜色方案 3Bit
		public var gctColorResolution : int;
		// 短标记 1Bit
		public var gctSorted : int;
		// 全局色表尺寸 3Bits
		public var gctNumColors : int;
		// 背景色索引
		public var bgColorIndex : int;
		// 象素高宽比（1字节）
		public var pixelAspect : int;

		public function GLSD() {
		}

		public function decode(value : ByteArray) : void {
			// 逻辑屏幕宽
			width = value.readUnsignedShort();
			// 逻辑屏幕高
			height = value.readUnsignedShort();
			packed = value.readUnsignedByte();
			// 全局色表 1Bit
			gct = (packed & 0x80) >> 7;
			// 颜色方案 3Bit
			gctColorResolution = (packed & 0x70) >> 4;
			// 短标记 1Bit
			gctSorted = (packed & 0x08) >> 3;
			// 全局色表尺寸 3Bits
			gctNumColors = packed & 0x07;
			// 背景色索引
			bgColorIndex = value.readUnsignedByte();
			// 象素高宽比（1字节）
			pixelAspect = value.readUnsignedByte();
		}

		public function encode(value : ByteArray) : void {
			value.writeShort(width);
			value.writeShort(height);
			packed = gct << 7;
			packed |= (gctColorResolution & 0x07) << 4;
			packed |= gctSorted << 3;
			packed |= gctNumColors & 0x07;
			value.writeByte(packed);
			value.writeByte(bgColorIndex);
			value.writeByte(pixelAspect);
		}
	}
}
