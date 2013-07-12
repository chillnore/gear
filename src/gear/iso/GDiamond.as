package gear.iso {
	import gear.utils.GDrawUtil;

	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * @author Administrator
	 */
	public class GDiamond extends Sprite {
		protected var _iso : IGIsoMap;
		protected var _label : TextField;

		public function GDiamond(tw : int, th : int) {
			_iso = new GStaggeredIso();
			GDrawUtil.drawDiamond(tw, th, graphics);
			_label = new TextField();
			_label.selectable = false;
			addChild(_label);
		}

		public function set text(value : String) : void {
			_label.text = value;
			_label.x = - (_label.textWidth + 3) / 2;
			_label.y = - (_label.textHeight + 1) / 2;
		}
	}
}
