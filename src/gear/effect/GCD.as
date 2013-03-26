package gear.effect {
	import gear.gui.model.GRangeModel;
	import gear.utils.GDrawUtil;
	import gear.utils.GMathUtil;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;

	public class GCD extends Sprite {
		private var _texture : BitmapData;
		private var _shadow : Shape;
		private var _mask : Shape;
		private var _model : GRangeModel;
		private var _width : int;
		private var _height : int;
		private var _halfW : int;
		private var _halfH : int;
		private var _radius : int;

		private function onModelChange() : void {
			redrawMask();
		}

		private function redrawShadow() : void {
			var g : Graphics = _shadow.graphics;
			g.clear();
			g.beginBitmapFill(_texture);
			g.drawRect(0, 0, _width, _height);
			g.endFill();
		}

		private function redrawMask() : void {
			var g : Graphics = _mask.graphics;
			var s : int = 270 + 360 * _model.percent;
			g.clear();
			g.beginFill(0xFF0000, 1);
			GDrawUtil.drawSector(g, _halfW, _halfH, _radius, s, 270);
			g.endFill();
		}

		public function GCD() {
			mouseEnabled = mouseChildren = false;
			_texture = new BitmapData(2, 2, true, 0);
			_texture.setPixel32(0, 0, 0x99000000);
			_texture.setPixel32(1, 1, 0x99000000);
			_texture.setPixel32(0, 1, 0xCC000000);
			_texture.setPixel32(1, 0, 0xCC000000);
			_shadow = new Shape();
			addChild(_shadow);
			_mask = new Shape();
			addChild(_mask);
			_shadow.mask = _mask;
			_model = new GRangeModel();
			_model.onChange = onModelChange;
		}

		public function setSize(w : int, h : int) : void {
			_width = w;
			_height = h;
			_halfW = _width * 0.5;
			_halfH = _height * 0.5;
			_radius = GMathUtil.getDistance(0, 0, _halfW, _halfH);
			redrawShadow();
			redrawMask();
		}

		public function get model() : GRangeModel {
			return _model;
		}
	}
}
