package gear.ui.data {
	import gear.log4a.LogError;
	import gear.net.AssetData;
	import gear.ui.core.GAlign;
	import gear.ui.core.GBaseData;
	import gear.ui.core.ScaleMode;
	import gear.ui.manager.UIManager;
	import gear.ui.skin.SkinStyle;
	import gear.ui.skin.pb.IPBSkin;
	import gear.ui.skin.pb.MCPBSkin;
	import gear.ui.skin.pb.PBMode;
	import gear.ui.skin.pb.PBScale;
	import gear.ui.skin.pb.PBSkin;
	import gear.ui.skin.pb.PolledSkin;

	import flash.display.MovieClip;
	import flash.display.Sprite;


	/**
	 * 进度条控件
	 * 
	 * @author bright
	 * @version 20101018
	 */
	public class GProgressBarData extends GBaseData {
		public var skin : IPBSkin;
		/**
		 * 标签元件定义
		 */
		public var labelData : GLabelData;
		/**
		 * 边空
		 */
		public var padding : int;
		/**
		 * 模式
		 */
		public var mode : int ;
		/**
		 * 进度条长度模式
		 */
		public var scale : int;
		/**
		 * 当前值
		 */
		public var value : int;
		/**
		 * 最大值
		 */
		public var max : int = 100;

		/**
		 * @private
		 */
		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GProgressBarData = source as GProgressBarData;
			if (data == null) {
				return;
			}
			data.skin = (skin != null ? skin.clone() : null);
			data.labelData = labelData.clone();
			data.padding = padding;
			data.scale = scale;
			data.mode = mode;
			data.value = value;
			data.max = max;
		}

		public function GProgressBarData() {
			var trackSkin : Sprite = UIManager.getSkin(new AssetData(SkinStyle.progressBar_trackSkin));
			var barSkin : Sprite = UIManager.getSkin(new AssetData(SkinStyle.progressBar_barSkin));
			var polledSkin : Sprite = new PolledSkin();
			skin = new PBSkin(trackSkin, barSkin, polledSkin);
			labelData = new GLabelData();
			labelData.align = GAlign.CENTER;
			mode = PBMode.MANUAL;
			scale = PBScale.SCALE;
			max = 100;
			width = 100;
			height = 10;
		}

		public function bindTo(mc : MovieClip) : void {
			if (mc == null) {
				throw new LogError("bind target is null!");
			}
			mc.gotoAndStop(1);
			x += Math.round(mc.x);
			y += Math.round(mc.y);
			skin = new MCPBSkin(mc);
			scaleMode = ScaleMode.NONE;
			align = null;
		}

		/**
		 * @inheritDoc
		 */
		override public function clone() : * {
			var data : GProgressBarData = new GProgressBarData();
			parse(data);
			return data;
		}
	}
}
