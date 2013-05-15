package gear.codec.gif {
	import gear.log4a.GLogger;

	import flash.utils.ByteArray;

	/**
	 * @author Administrator
	 */
	public class GGraphicsControl {
		public var packed : int;
		// 保留
		public var reserved : int;
		// 配置方法
		public var disposalMethod : int;
		// 用户输入
		public var userInput : int;
		// 透明
		public var transparency : int;
		// 延时
		public var delayTime : int;
		// 透明索引
		public var transparencyIndex : int;

		public function GraphicsControl() : void {
		}

		public function decode(value : ByteArray) : void {
			var length : int = value.readUnsignedByte();
			if (length != 4) {
			}
			packed = value.readUnsignedByte();
			reserved = (packed & 0xE0) >> 5;
			disposalMethod = (packed & 0x1C) >> 2;
			userInput = (packed & 0x02) >> 1;
			transparency = packed & 0x01;
			delayTime = value.readUnsignedShort();
			transparencyIndex = value.readUnsignedByte();
			value.readUnsignedByte();
			GLogger.debug("图像控制扩充:块长", length, "保留", reserved, "配置方法", disposalMethod, "用户输入", userInput, "透明", transparency, "延时", delayTime, "透明索引", transparencyIndex);
		}

		public function encode(value : ByteArray) : void {
			value.writeByte(0x21);
			value.writeByte(0xF9);
			value.writeByte(4);
			packed = (reserved & 0x07) << 5;
			packed |= (disposalMethod & 0x07) << 2;
			packed |= (userInput & 0x01) << 1;
			packed |= transparency & 0x01;
			value.writeByte(packed);
			value.writeShort(delayTime);
			value.writeByte(transparencyIndex);
			value.writeByte(0);
		}
	}
}
