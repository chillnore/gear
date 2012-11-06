package gear.ui.core {
	import gear.ui.controls.GToolTip;
	import gear.ui.data.GToolTipData;
	import gear.ui.effect.IEffect;

	import flash.display.DisplayObjectContainer;

	/**
	 * GBaseData 控件定义基类
	 * 
	 * @author bright
	 * @version 20121105
	 */
	public class GBaseData {
		/**
		 * 控件父容器
		 */
		public var parent : DisplayObjectContainer;
		/**
		 * 控件X坐标
		 */
		public var x : int = 0;
		/**
		 * 控件Y坐标
		 */
		public var y : int = 0;
		/**
		 * 控件宽度
		 */
		public var width : int = 0;
		/**
		 * 控件高度
		 */
		public var height : int = 0;
		/**
		 * 透明度
		 */
		public var alpha : Number = 1;
		/**
		 * 是否可用
		 */
		public var enabled : Boolean = true;
		/**
		 * 是否可见
		 */
		public var visible : Boolean = true;
		/**
		 * 最小宽度
		 */
		public var minWidth : int = 0;
		/**
		 * 最小高度
		 */
		public var minHeight : int = 0;
		/**
		 * 最大宽度
		 */
		public var maxWidth : int = 2880;
		/**
		 * 最大高度
		 */
		public var maxHeight : int = 1000;
		/**
		 * 缩放模式
		 * @see gear.ui.core.ScaleMode
		 */
		public var scaleMode : int = GScaleMode.SCALE9GRID;
		/**
		 * 对齐
		 * @see gear.ui.core.GAlign
		 */
		public var align : GAlign;
		/**
		 * 滤镜数组
		 */
		public var filters : Array;
		/**
		 * 显示效果
		 */
		public var showEffect : IEffect;
		/**
		 * 隐藏效果
		 */
		public var hideEffect : IEffect;
		/**
		 * 提示控件类
		 * @see gear.ui.controls.GToolTip
		 */
		public var toolTip : Class = GToolTip;
		/**
		 * 提示控件定义
		 * @see gear.ui.data.GToolTipData
		 */
		public var toolTipData : GToolTipData;

		/**
		 * @private
		 */
		protected function parse(source : *) : void {
			var data : GBaseData = source as GBaseData;
			if (data == null) {
				return;
			}
			data.parent = parent;
			data.x = x;
			data.y = y;
			data.width = width;
			data.height = height;
			data.alpha = alpha;
			data.enabled = enabled;
			data.visible = visible;
			data.minWidth = minWidth;
			data.minHeight = minHeight;
			data.maxWidth = maxWidth;
			data.maxHeight = maxHeight;
			data.scaleMode = scaleMode;
			data.align = (align != null ? align.clone() : null);
			data.filters = (filters ? filters.concat() : null);
			data.showEffect = showEffect;
			data.hideEffect = hideEffect;
			data.toolTip = toolTip;
			data.toolTipData = (toolTipData != null ? toolTipData.clone() : null);
		}

		/**
		 * 构造函数
		 */
		public function GBaseData() {
		}

		/**
		 * 克隆定义
		 * 
		 * @return * 克隆定义
		 */
		public function clone() : * {
			var data : GBaseData = new GBaseData();
			parse(data);
			return data;
		}
	}
}
