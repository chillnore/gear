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
		/**
		 * 配置方法
		 * 0 - 无指定的配置，解码器不需要做任何处理。
		 * 1 - 不做配值。图像将被留在原位置。
		 * 2 - 恢复背景颜色。图像所占的区域必须备恢复为背景颜色。
		 * 3 - 恢复以前的颜色。解码器需要将图像区域恢复为原来成象的颜色。
		 */
		public var disposalMethod : int;
		// 用户输入
		public var userInput : int;
		// 透明
		public var transparency : int;
		// 延时
		public var delayTime : int;
		// 透明索引
		public var transparencyIndex : int;

		public function GGraphicsControl() : void {
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
