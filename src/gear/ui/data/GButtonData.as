package gear.ui.data {
	import gear.log4a.LogError;
	import gear.net.AssetData;
	import gear.ui.core.GAlign;
	import gear.ui.core.GBaseData;
	import gear.ui.core.ScaleMode;
	import gear.ui.manager.UIManager;
	import gear.ui.skin.SkinStyle;
	import gear.ui.skin.button.ButtonSkin;
	import gear.ui.skin.button.IButtonSkin;
	import gear.ui.skin.button.MCButtonSkin;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;

	/**
	 * 按钮控件定义
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class GButtonData extends GBaseData {
		protected var _skin : IButtonSkin;
		/**
		 * 标签控件定义
		 */
		public var labelData : GLabelData;
		/**
		 * 边空
		 */
		public var padding : int;

		/**
		 * @private
		 */
		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GButtonData = source as GButtonData;
			if (data == null) {
				return;
			}
			data.skin = (skin != null ? skin.clone() : null);
			data.labelData = (labelData ? labelData.clone() : null);
		}

		public function GButtonData() {
			width = 70;
			height = 24;
			var upSkin : Sprite = UIManager.getSkin(new AssetData(SkinStyle.button_upSkin));
			var overSkin : Sprite = UIManager.getSkin(new AssetData(SkinStyle.button_overSkin));
			var downSkin : Sprite = UIManager.getSkin(new AssetData(SkinStyle.button_downSkin));
			var disabledSkin : Sprite = UIManager.getSkin(new AssetData(SkinStyle.button_disabledSkin));
			_skin = new ButtonSkin(upSkin, overSkin, downSkin, disabledSkin);
			labelData = new GLabelData();
			labelData.align = new GAlign(-1, -1, -1, -1, 0, 0);
			labelData.color.overColor = 0xFFFFFF;
			labelData.color.disabledColor = 0x898989;
			padding = 3;
		}

		/**
		 * 绑定MovieClip到按钮控件皮肤
		 * 
		 * @param mc MovieClip
		 */
		public function bindTo(mc : MovieClip) : void {
			if (mc == null) {
				throw new LogError("bind target is null!");
			}
			mc.gotoAndStop(1);
			x += Math.round(mc.x);
			y += Math.round(mc.y);
			var label : TextField = mc.getChildByName("label") as TextField;
			if (label != null) {
				labelData.bindTo(label);
				labelData.align = null;
				mc.addEventListener(Event.RENDER, function() : void {
					var tf : TextField = mc.getChildByName("label") as TextField;
					if (tf != null) {
						tf.parent.removeChild(tf);
					}
				});
			}
			_skin = new MCButtonSkin(mc);
			scaleMode = ScaleMode.NONE;
			align = null;
		}

		public function set skin(value : IButtonSkin) : void {
			_skin = value;
			var mc : MovieClip;
			if (_skin is MCButtonSkin) {
				mc = MCButtonSkin(_skin).mc;
				var label : TextField = mc.getChildByName("label") as TextField;
				if (label != null) {
					labelData.bindTo(label);
					mc.addFrameScript(0, function() : void {
						var tf : TextField = mc.getChildByName("label") as TextField;
						if (tf != null) {
							tf.parent.removeChild(tf);
						}
					});
				}
			}
		}

		public function get skin() : IButtonSkin {
			return _skin;
		}

		/**
		 * @inheritDoc
		 */
		override public function clone() : * {
			var data : GButtonData = new GButtonData();
			parse(data);
			return data;
		}
	}
}
