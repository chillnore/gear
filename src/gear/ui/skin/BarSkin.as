package gear.ui.skin {
	import gear.utils.GColorUtil;
	import gear.utils.GDrawUtil;
	import gear.utils.GMathUtil;

	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	/**
	 * @author flashpf
	 */
	public class BarSkin extends Skin {
		protected var _color : uint;
		protected var _alpha : Number;

		override protected function layout() : void {
		}

		protected function redraw() : void {
			var g : Graphics = graphics;
			GDrawUtil.drawFillBorder(g, 0x000000, 0.03, 0, 0, 50, 50);
			GDrawUtil.drawFillBorder(g, 0x000000, 0.05, 1, 1, 48, 48);
			GDrawUtil.drawRect(g, _color, _alpha, 2, 2, 46, 46);
			var mtx : Matrix = new Matrix();
			mtx.createGradientBox(46, 46, GMathUtil.angleToRadian(90), 2, 2);
			var lightColor : uint = GColorUtil.adjustBrightness(_color, 63);
			g.beginGradientFill(GradientType.LINEAR, [lightColor, _color], [_alpha, _alpha], [0, 255], mtx);
			g.drawRect(2, 2, 46, 46);
			g.endFill();
			g.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xFFFFFF], [0.2, 0.1], [0, 255], mtx);
			GDrawUtil.drawBorder(g, 2, 2, 46, 46);
			g.endFill();
			scale9Grid = new Rectangle(4, 4, 42, 42);
		}

		public function BarSkin(color : uint, alpha : Number = 1) {
			_color = color;
			_alpha = alpha;
			redraw();
		}

		public function set color(value : uint) : void {
			if (_color == value) {
				return;
			}
			_color = value;
			redraw();
		}
	}
}
