package gear.ui.data {
	import gear.ui.core.GBaseData;

	import flash.text.StyleSheet;

	/**
	 * 状态监视器定义
	 * 
	 * @author bright
	 * @version 20110905
	 */
	public class GStatsData extends GBaseData {
		public var bgColor : uint;
		public var fpsColor : uint;
		public var msColor : uint;
		public var memColor : uint;
		public var maxMemColor : uint;
		private var _css : StyleSheet;

		public function GStatsData() {
			width = 70;
			height = 100;
			bgColor = 0x000033;
			fpsColor = 0xffff00;
			msColor = 0x00ff00;
			memColor = 0x00ffff;
			maxMemColor = 0xff0070;
			_css = new StyleSheet();
			_css.setStyle("xml", {fontSize:'9px', fontFamily:'_sans', leading:'-2px'});
			_css.setStyle("fps", {color:"#" + fpsColor.toString(16)});
			_css.setStyle("ms", {color:"#" + msColor.toString(16)});
			_css.setStyle("mem", {color:"#" + memColor.toString(16)});
			_css.setStyle("maxMem", {color:"#" + maxMemColor.toString(16)});
		}

		public function get css() : StyleSheet {
			return _css;
		}
	}
}
