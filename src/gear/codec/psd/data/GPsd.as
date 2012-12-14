package gear.codec.psd.data {
	import gear.data.GTree;
	import gear.data.GTreeNode;

	import flash.display.BitmapData;

	/**
	 * Psd数据
	 * 
	 * @author bright
	 * @version 20121110
	 */
	public class GPsd {
		// 签名 8BPS
		public var signature : String;
		// 版本 1
		public var version : int;
		// 通道数包括透明通道:范围1-56
		public var channels : int;
		// 画布高度:范围1-30000像素
		public var height : int;
		// 画布宽度:范围1-30000像素
		public var width : int;
		// 色彩位数:1,8,16
		public var colorDepth : int;
		// 色彩模式:Bitmap=0;Grayscale=1;Indexed=2;RGB=3;CMYK=4;Multichannel=7;Duotone=8;Lab=9
		public var colorMode : int;
		// 层数量
		public var layerCount : int;
		public var tree : GTree;
		public var layers : Vector.<GPsdLayer>;
		public var bitmapData : BitmapData;

		public function GPsd() : void {
			tree = new GTree();
		}

		public function getLayerBy(path : String) : GPsdLayer {
			var params : Array = path.split("/");
			var start : GTreeNode = tree.root;
			for (var i : int;i < params.length;i++) {
				start = start.findAt("name", params[i]);
				if (start == null) {
					return null;
				}
			}
			return start.data as GPsdLayer;
		}
	}
}
