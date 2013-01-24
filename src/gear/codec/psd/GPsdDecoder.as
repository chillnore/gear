package gear.codec.psd {
	import gear.core.IDispose;
	import gear.codec.psd.data.GPsd;
	import gear.codec.psd.data.GPsdBlendMode;
	import gear.codec.psd.data.GPsdChannel;
	import gear.codec.psd.data.GPsdLayer;
	import gear.codec.psd.data.GPsdMask;
	import gear.data.GTreeNode;
	import gear.gui.utils.GUIUtil;
	import gear.log4a.GLogError;
	import gear.log4a.GLogger;

	import flash.display.Bitmap;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Endian;


	/**
	 * Psd文件解码器 
	 *  
	 * @author bright
	 * @version 201301116
	 */
	public final class GPsdDecoder implements IDispose{
		private var _data : ByteArray;
		private var _psd : GPsd;

		private function parseHeader() : void {
			// 签名 8BPS
			_psd.signature = _data.readUTFBytes(4);
			if (_psd.signature != "8BPS" ) {
				GLogger.warn("无效签名:" + _psd.signature);
				return;
			}
			// 版本 1
			_psd.version = _data.readUnsignedShort();
			if (_psd.version != 1) {
				GLogger.warn("无效版本: " + _psd.version);
				return;
			}
			// 保留6字节,必须是0x00
			_data.position += 6;
			// 通道数包括透明通道:范围1-56
			_psd.channels = _data.readUnsignedShort();
			// 画布高度:范围1-30000像素
			_psd.height = _data.readInt();
			// 画布宽度:范围1-30000像素
			_psd.width = _data.readInt();
			// 色彩位数:1,8,16
			_psd.colorDepth = _data.readUnsignedShort();
			if (_psd.colorDepth != 8) {
				GLogger.warn("建议使用8位色深通道的PSD解码");
			}
			// 色彩模式:Bitmap=0;Grayscale=1;Indexed=2;RGB=3;CMYK=4;Multichannel=7;Duotone=8;Lab=9
			_psd.colorMode = _data.readUnsignedShort();
			if (_psd.colorMode != 3) {
				throw GLogError("仅支持RGB色彩模式的PSD解码");
			}
		}

		private function parseColorModeData() : void {
			// 除索引与双色颜色模式外长度为0
			var length : int = _data.readInt();
			// 跳过解析
			_data.position += length;
		}

		private function parseImageResources() : void {
			// 位图资源长度
			var length : uint = _data.readUnsignedInt();
			var end : uint = _data.position + length;
			var sig : String;
			while (_data.position < end ) {
				sig = _data.readUTFBytes(4);
				if ( sig != "8BIM") {
					throw new GLogError("无效签名:" + sig);
				}
				// 资源索引
				var resourceID : int = _data.readUnsignedShort();
				resourceID;
				// 资源名字: Pascal string,一个空名字是2个为0的字节.
				var sizeOfName : int = _data.readUnsignedByte();
				sizeOfName += 1 - sizeOfName % 2;
				var name : String = _data.readMultiByte(sizeOfName, "gb2312").toString();
				name;
				// 资源长度
				var resourceSize : uint = _data.readUnsignedInt();
				resourceSize += resourceSize % 2;
				var skip : uint = _data.position + resourceSize;
				_data.position = skip;
			}
			_data.position = end;
		}

		private function parseLayerAndMaskInfo() : void {
			// 层与遮罩信息长度
			var length : uint = _data.readUnsignedInt();
			var end : uint = _data.position + length;
			if ( length > 0 ) {
				// 层信息
				parseLayerInfo();
				// 遮罩信息
				parseGlobalLayerMaskInfo();
				_data.position = end;
			}
		}

		private function parseLayerInfo() : void {
			var length : uint = _data.readUnsignedInt();
			if (length < 1) {
				_data.readInt();
				var sig : String = _data.readUTFBytes(4);
				if ( sig != "8BIM") {
					throw new GLogError("无效签名:" + sig);
				}
				var key : String = _data.readUTFBytes(4);
				if (key == "Lr16") {
					length = _data.readInt();
				} else if (key == "Mt16") {
					_data.readInt();
					sig = _data.readUTFBytes(4);
					if ( sig != "8BIM") {
						throw new GLogError("无效签名:" + sig);
					}
					key = _data.readUTFBytes(4);
					if (key == "Lr16") {
						length = _data.readInt();
					}
				} else if (key == "Lr32") {
					length = _data.readInt();
				}
			}
			var end : int = _data.position + length;
			// 层数量
			_psd.layerCount = Math.abs(_data.readShort());
			_psd.layers = new Vector.<GPsdLayer>(_psd.layerCount);
			var current : GTreeNode = _psd.tree.root;
			var node : GTreeNode;
			var layer : GPsdLayer;
			for (var i : int = 0; i < _psd.layerCount;++i ) {
				layer = parseLayerRecord();
				if (layer.type == GPsdLayer.BOUNDING_SECTION) {
					node = new GTreeNode();
					current.add(node);
					current = node;
				} else if (layer.type == GPsdLayer.FOLDER_OPEN || layer.type == GPsdLayer.FOLDER_CLOSED) {
					current.data = layer;
					current = current.parent;
				} else {
					current.add(new GTreeNode(layer));
				}
				_psd.layers[i] = layer;
			}
			for (i = 0;i < _psd.layerCount;++i) {
				parseChannelImageData(_psd.layers[i]);
			}
			_data.position = end;
		}

		private function parseLayerRecord() : GPsdLayer {
			var layer : GPsdLayer = new GPsdLayer();
			layer.bounds = parseRect();
			layer.channelCount = _data.readUnsignedShort();
			layer.channels = new Vector.<GPsdChannel>(layer.channelCount);
			for ( var i : uint = 0; i < layer.channelCount; ++i ) {
				layer.channels[i] = parseChannel();
			}
			var sig : String = _data.readUTFBytes(4);
			if (sig != "8BIM") {
				throw new GLogError("无效签名:" + sig);
			}
			var blendModeKey : String = _data.readUTFBytes(4);
			layer.blendModeKey = blendModeKey;
			layer.alpha = _data.readUnsignedByte() / 255;
			layer.clipping = _data.readBoolean();
			var flags : int = _data.readUnsignedByte();
			layer.transparencyProtected = ((flags & 0x1)) != 0;
			layer.visible = ((flags >> 1) & 0x1) == 0;
			layer.obsolete = ((flags >> 2) & 1) != 0;
			layer.pixelDataIrrelevant = false;
			if (((flags >> 3) & 0x01) != 0) {
				layer.pixelDataIrrelevant = ((flags >> 4) & 0x01) != 0;
			}
			var filler : int = _data.readByte();
			if (filler != 0) {
				throw GLogError("保留字节,必须是0");
			}
			parseExtraData(layer);
			return layer;
		}

		private function parseRect() : Rectangle {
			var y : int = _data.readInt();
			var x : int = _data.readInt();
			var bottom : int = _data.readInt();
			var right : int = _data.readInt();
			return new Rectangle(x, y, right - x, bottom - y);
		}

		private function parseChannel() : GPsdChannel {
			var channel : GPsdChannel = new GPsdChannel();
			channel.id = _data.readShort();
			channel.length = _data.readUnsignedInt();
			return channel;
		}

		private function parseExtraData(layer : GPsdLayer) : void {
			var size : uint = _data.readUnsignedInt();
			var pos : int = _data.position;
			parseMaskAndAdjustmentData(layer);
			parseLayerBlendingRangesData(layer);
			var sizeOfName : uint = _data.readUnsignedByte();
			sizeOfName += 3 - sizeOfName % 4;
			layer.name = _data.readMultiByte(sizeOfName, "gb2312");
			while (_data.position - pos < size) {
				parseAdditionalLayerInfo(layer);
			}
			_data.position = pos + size;
		}

		private function parseAdditionalLayerInfo(layer : GPsdLayer) : void {
			var sig : String = _data.readUTFBytes(4);
			if (sig != "8BIM") {
				throw new GLogError("无效签名: " + sig);
			}
			var key : String = _data.readUTFBytes(4);
			var size : int = _data.readUnsignedInt();
			var end : int = _data.position + size;
			var buffer : ByteArray;
			switch(key) {
				// Unicode layer name (Photoshop 5.0)
				case "luni":
					var len : int = _data.readInt();
					if (len != size - 4) {
						len = size - 4;
					}
					layer.unicodeName = _data.readMultiByte(len, "unicodeFFFE");
					break;
				// Layer name source setting (Photoshop 6.0)
				case "lnsr":
					layer.nameId = _data.readInt();
					break;
				// Layer ID (Photoshop 5.0)
				case "lyid":
					layer.id = _data.readInt();
					break;
				// Section divider setting (Photoshop 6.0)
				case "lsct":
					parseSectionDivider(layer, size);
					break;
				/**
				 * Blend clipping elements (Photoshop 6.0)
				 * 1字节 Blend clipped elements: boolean
				 * 3字节 Padding
				 */ 
				case "clbl":
					_data.position += 4;
					break;
				/**
				 * Blend interior elements (Photoshop 6.0)
				 * 1字节 Blend interior elements: boolean
				 * 3字节 Padding
				 */ 
				case "infx":
					_data.position += 4;
					break;
				/**
				 * Knockout setting (Photoshop 6.0)
				 * 1字节 Knockout: boolean
				 * 3字节 Padding
				 */ 
				case "knko":
					_data.position += 4;
					break;
				// Protected setting (Photoshop 6.0)
				case "lspf":
					var flags : int = _data.readInt();
					flags;
					break;
				// Sheet color setting (Photoshop 6.0)
				case "lclr":
					buffer = new ByteArray();
					_data.readBytes(buffer, 0, size);
					break;
				// Metadata setting (Photoshop 6.0)
				case "shmd":
					parseMetaData(layer);
					break;
				// Reference point (Photoshop 6.0)
				case "fxrp":
					layer.referencePoint = new Point(_data.readDouble(), _data.readDouble());
					break;
				// Layer version (Photoshop 7.0)
				case "lyvr":
					break;
				// Solid color sheet setting (Photoshop 6.0)
				case "SoCo":
					break;
				// Object-based effects layer info (Photoshop 6.0)
				case "lfx2":
					var objectEffectVersion : int = _data.readInt();
					var descriptorVersion : int = _data.readInt();
					objectEffectVersion;
					descriptorVersion;
					// Descriptor structure
					_data.position = end;
					break;
				// Effects Layer (Photoshop 5.0)
				case "lrFX":
					parseEffectLayer(layer);
					break;
				default:
					trace("?", key);
					break;
			}
			if (_data.position != end) {
				trace("decode error", key, _data.position, end);
			}
			_data.position = end;
		}

		/**
		 * lrFX
		 */
		private function parseEffectLayer(layer : GPsdLayer) : void {
			// version:0
			var version : int = _data.readUnsignedShort();
			version;
			// Effects count: may be 6 (for the 6 effects in Photoshop 5 and 6) or 7 (for Photoshop 7.0)
			var effectCount : int = _data.readUnsignedShort();
			var sig : String;
			var effectSig : String;
			var size : int;
			for (var i : int = 0;i < effectCount;++i) {
				sig = _data.readUTFBytes(4);
				if (sig != "8BIM") {
					throw new GLogError("无效签名: " + sig);
				}
				effectSig = _data.readUTFBytes(4);
				size = _data.readInt();
				switch(effectSig) {
					// Effects layer, common state info
					case "cmnS":
						_data.position += size;
						break;
					// Effects layer, drop shadow info
					case "dsdw":
						parseDropShadow(layer, false);
						break;
					// Effects layer, inner shadow info
					case "isdw":
						parseDropShadow(layer, true);
						break;
					// Effects layer, outer glow info
					case "oglw":
						parseGlow(layer, false);
						break;
					// Effects layer, inner glow info
					case "iglw":
						parseGlow(layer, true);
						break;
					case "bevl":
						_data.position += size;
						break;
					case "sofi":
						_data.position += size;
						break;
					default:
						_data.position += size;
						trace("$", effectSig);
						return;
				}
			}
			_data.position += 2;
		}

		private function parseDropShadow(layer : GPsdLayer, inner : Boolean) : void {
			var version : int = _data.readInt();
			version;
			var blur : int = _data.readShort();
			var intensity : int = _data.readInt();
			intensity;
			var angle : int = _data.readInt();
			var distance : int = _data.readInt();
			_data.position += 4;
			var color : uint = GPsdUtil.parseColor(_data);
			var blendSig : String = _data.readUTFBytes(4);
			if (blendSig != "8BIM") {
				throw new GLogError("无效签名: " + blendSig);
			}
			var blendMode : String = GPsdBlendMode.getAS3BlendMode(_data.readUTFBytes(4));
			blendMode;
			var effectEnabled : Boolean = _data.readBoolean();
			var useAngleInAllLayerEffect : Boolean = _data.readBoolean();
			useAngleInAllLayerEffect;
			var alpha : Number = _data.readUnsignedByte() / 255;
			_data.position += 2;
			var nativeColor : uint = GPsdUtil.parseColor(_data);
			nativeColor;
			if (effectEnabled) {
				var dropShadowFilter : DropShadowFilter = new DropShadowFilter();
				dropShadowFilter.alpha = alpha;
				dropShadowFilter.angle = 180 - angle;
				dropShadowFilter.blurX = blur;
				dropShadowFilter.blurY = blur;
				dropShadowFilter.color = color;
				dropShadowFilter.quality = 4;
				dropShadowFilter.distance = distance;
				dropShadowFilter.inner = inner;
				dropShadowFilter.strength = 1;
				layer.filters.push(dropShadowFilter);
			}
		}

		private function parseGlow(layer : GPsdLayer, inner : Boolean = false) : void {
			var version : int = _data.readInt();
			var blur : int = _data.readShort();
			var intensity : int = _data.readInt();
			intensity;
			_data.position += 4;
			var color : uint = GPsdUtil.parseColor(_data);
			var blendSig : String = _data.readUTFBytes(4);
			if (blendSig != "8BIM") {
				throw new GLogError("无效签名: " + blendSig);
			}
			var blendModeKey : String = _data.readUTFBytes(4);
			blendModeKey;
			var effectEnabled : Boolean = _data.readBoolean();
			var alpha : Number = _data.readUnsignedByte() / 255;
			if (version == 2) {
				if (inner) {
					var invert : Boolean = _data.readBoolean();
					invert;
				}
				_data.position += 2;
				var nativeColor : uint = GPsdUtil.parseColor(_data);
				nativeColor;
			}
			if (effectEnabled) {
				var glowFilter : GlowFilter = new GlowFilter();
				glowFilter.alpha = alpha;
				glowFilter.blurX = blur;
				glowFilter.blurY = blur;
				glowFilter.color = color;
				glowFilter.quality = 4;
				glowFilter.strength = 1;
				glowFilter.inner = inner;
				layer.filters.push(glowFilter);
			}
		}

		/**
		 * Section divider setting (Photoshop 6.0)
		 * 4字节 类型. 4个合理的值 
		 *    0=图层
		 *    1=文件夹-打开
		 *    2=文件夹-关闭
		 *    3=边界,在界面中不显示
		 * 4字节 签名 8BIM
		 * 4字节 混合模式
		 */
		private function parseSectionDivider(layer : GPsdLayer, size : int) : void {
			var dividerType : int = _data.readInt();
			if (dividerType < 0 || dividerType > 3) {
				throw new GLogError("无效类型:" + dividerType);
			}
			layer.type = dividerType;
			if (size == 4) {
				return;
			}
			var sig : String = _data.readUTFBytes(4);
			if (sig != "8BIM") {
				throw new GLogError("无效签名:" + sig);
			}
			var blendModeKey : String = _data.readUTFBytes(4);
			layer.dividerBlendModeKey = blendModeKey;
			if (size == 16) {
				_data.readInt();
			}
		}

		private function parseMetaData(layer : GPsdLayer) : void {
			layer;
			var count : int = _data.readInt();
			var sig : String;
			var key : String;
			var copy : int;
			var len : int;
			for (var i : int = 0;i < count;i++) {
				sig = _data.readUTFBytes(4);
				if (sig != "8BIM") {
					throw new GLogError("无效签名:" + sig);
				}
				key = _data.readUTFBytes(4);
				copy = _data.readByte();
				// Padding
				_data.position += 3;
				len = _data.readInt();
				// data
				_data.position += len;
			}
		}

		private function parseMaskAndAdjustmentData(layer : GPsdLayer) : void {
			var size : uint = _data.readUnsignedInt();
			if (!(size == 0 || size == 20 || size == 36)) {
				throw new GLogError("Invalid mask size");
			}
			if (size > 0 ) {
				layer.mask = new GPsdMask();
				layer.mask.bounds = parseRect();
				layer.mask.defaultColor = _data.readUnsignedByte();
				var flags : uint = _data.readUnsignedByte();
				layer.mask.relative = (flags & 0x1) != 0;
				layer.mask.disabled = ((flags >> 1) & 0x01) != 0;
				layer.mask.invert = ((flags >> 2) & 0x01) != 0;
				if (size == 20) {
					layer.mask.padding = _data.readShort();
				} else {
					var realFlags : uint = _data.readUnsignedByte();
					layer.mask.relative = (realFlags & 0x01) != 0;
					layer.mask.disabled = ((realFlags >> 1) & 0x01) != 0;
					layer.mask.invert = ((realFlags >> 2) & 0x01) != 0;
					layer.mask.defaultColor = _data.readUnsignedByte();
					layer.mask.bounds = parseRect();
				}
			}
		}

		private function parseLayerBlendingRangesData(layer : GPsdLayer) : void {
			layer;
			var length : uint = _data.readUnsignedInt();
			// 跳过解析
			_data.position += length;
		}

		private function parseGlobalLayerMaskInfo() : void {
			var length : uint = _data.readUnsignedInt();
			if (length > 0) {
				var overlayColorSpace : uint = _data.readUnsignedShort();
				var color1 : uint = _data.readUnsignedInt();
				var color2 : uint = _data.readUnsignedInt();
				var opacity : uint = _data.readUnsignedShort();
				var kind : uint = _data.readUnsignedByte();
				var filler : int = _data.readUnsignedByte();
				trace("globalLayerMaskInfo", length, overlayColorSpace, color1.toString(16), color2.toString(16), opacity, kind, filler);
			}
		}

		private function parseChannelImageData(layer : GPsdLayer) : void {
			for each (var channel:GPsdChannel in layer.channels) {
				channel.compression = _data.readUnsignedShort();
				trace("channelImageData", layer.name, layer.channelCount, channel.compression, channel.id, channel.length);
				channel.source = new ByteArray();
				if (channel.length - 2 > 1) {
					_data.readBytes(channel.source, 0, channel.length - 2);
				}
			}
			if (layer.type != GPsdLayer.OTHER) {
				return;
			}
			var width : int = layer.bounds.width;
			var height : int = layer.bounds.height;
			if (width * height == 0) {
				return;
			}
			var channels : Vector.<ByteArray>=new Vector.<ByteArray>(layer.channelCount);
			var i : int;
			for each (channel in layer.channels) {
				i = channel.id;
				if (channel.id < 0) {
					if (channel.id == -1) {
						i = 3;
					} else if (channel.id == -2) {
						GLogger.debug("暂不支持mask channel");
						continue;
					} else {
						GLogger.debug("暂不支持alpha channel");
						continue;
					}
				}
				if (channel.compression == 0) {
					channels[i] = GPsdUtil.toRGB(channel.source, _psd.colorDepth);
				} else if (channel.compression == 1) {
					channels[i] = GPsdUtil.toRGB(GPsdUtil.decodeRLE(channel.source, height), _psd.colorDepth);
				} else {
					// 仅支持Raw与RLE解码
					return;
				}
			}
			layer.bitmapData = GPsdUtil.renderToBD(channels, width, height);
		}

		private function parseImageData() : void {
			var compression : int = _data.readUnsignedShort();
			var channels : Vector.<ByteArray> = new Vector.<ByteArray>();
			var i : int;
			var j : int;
			var size : uint;
			var buffer : ByteArray;
			if (compression == 0) {
				size = _psd.width * _psd.height;
				for (i = 0;i < _psd.channels;++i) {
					buffer = new ByteArray();
					_data.readBytes(buffer, 0, size);
					GPsdUtil.toRGB(buffer, _psd.colorDepth);
					channels[i] = buffer;
				}
			} else if (compression == 1) {
				var lines : Array = new Array(_psd.height * _psd.channels);
				for ( i = 0; i < _psd.height * _psd.channels; ++i ) {
					lines[i] = _data.readUnsignedShort();
				}
				for (i = 0; i < _psd.channels; ++i) {
					buffer = new ByteArray();
					for ( j = 0; j < _psd.height; ++j ) {
						var line : ByteArray = new ByteArray();
						_data.readBytes(line, 0, lines[i * _psd.height + j]);
						buffer.writeBytes(GPsdUtil.decodeRLELine(line));
					}
					channels[i] = GPsdUtil.toRGB(buffer, _psd.colorDepth);
				}
			} else {
				return;
			}
			_psd.bitmapData = GPsdUtil.renderToBD(channels, _psd.width, _psd.height);
		}

		public function GPsdDecoder() {
			_psd = new GPsd();
		}

		public function decode(data : ByteArray) : void {
			_data = data;
			_data.endian = Endian.BIG_ENDIAN;
			parseHeader();
			parseColorModeData();
			parseImageResources();
			parseLayerAndMaskInfo();
			parseImageData();
			// trace(_data.position, _data.length);
			//GUIUtil.root.addChild(new Bitmap(_psd.bitmapData));
			// trace("$", _psd.layers[0].name);
			var bitmap : Bitmap = new Bitmap();
			//bitmap.filters = _psd.getLayerBy("Group 1/Layer 1").filters;
			bitmap.bitmapData = _psd.getLayerBy("Group 1/Layer 1").bitmapData;
			GUIUtil.root.addChild(bitmap);
		}
		
		public function dispose():void{
		}
	}
}