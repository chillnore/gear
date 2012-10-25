package gear.net {
	import flash.geom.Rectangle;

	import gear.log4a.LogError;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	/**
	 * 元件定义
	 * 
	 * @author bright
	 * @version 20120503
	 */
	public final class AssetData {
		/**
		 * 脚本库
		 */
		public static const AS_LIB : String = "as";
		/**
		 * 界面库
		 */
		public static const SWF_LIB : String = "ui.swf";
		/**
		 * 类名称
		 */
		private var _className : String;
		/**
		 * 库索引
		 */
		private var _libId : String;
		/**
		 * 绑定容器
		 */
		private var _parent : DisplayObjectContainer;
		/**
		 * 位图九宫格的缩放区域
		 */
		private var _scale9 : Rectangle;

		/**
		 * 构造函数
		 * 
		 * @param className String 类名称
		 * @param libId String 所在库索引 @default SWF_LIB
		 * <listing version="3.0"> AssetData使用示例
		 * var logo:Sprite=RESManager.getSprite(new AssetData("logo"));
		 * if(logo!=null){
		 * 		addChild(logo);
		 * }
		 * </listing> 
		 * @see gear.net.RESManager
		 */
		public function AssetData(className : String = "none", libId : String = SWF_LIB) {
			_className = className;
			_libId = libId;
		}

		public function set className(value : String) : void {
			_className = value;
		}

		/**
		 * return String 类名称
		 */
		public function get className() : String {
			return _className;
		}

		public function set libId(value : String) : void {
			_libId = value;
		}

		/**
		 * return String 库索引
		 */
		public function get libId() : String {
			return _libId;
		}

		/**
		 * return String 键
		 */
		public function get key() : String {
			return _className + ":" + _libId;
		}

		/**
		 * 获得绑定皮肤
		 * @return 绑定皮肤
		 */
		public function getSkin() : Sprite {
			var skin : Sprite = _parent.getChildByName(_className) as Sprite;
			if (skin == null) {
				throw new LogError("not found " + _className);
			}
			return skin;
		}

		public function set scale9(value : Rectangle) : void {
			_scale9 = value;
		}

		public function get scale9() : Rectangle {
			return _scale9;
		}
	}
}
