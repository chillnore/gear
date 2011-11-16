package gear.net {
	import gear.log4a.LogError;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	/**
	 * 元件定义
	 * 
	 * @author bright
	 * @version 20110923
	 */
	public final class AssetData {
		/**
		 * 脚本库
		 */
		public static const AS_LIB : String = "as";
		/**
		 * 界面库
		 */
		public static const SWF_LIB : String = "ui";
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
		public function AssetData(className : String, libId : String = SWF_LIB) {
			_className = className;
			_libId = libId;
		}

		/**
		 * return String 类名称
		 */
		public function get className() : String {
			return _className;
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
	}
}
