package gear.effect {
	import gear.ui.model.RangeModel;
	import gear.ui.skin.ASSkin;
	import gear.utils.GDrawUtil;
	import gear.utils.MathUtil;

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * 
	 * @author bright
	 * @version 20110925
	 */
	public class CDEffect extends Sprite {
		private var _texture : BitmapData;
		private var _shadow : Shape;
		private var _mask : Shape;
		private var _model : RangeModel;
		private var _width : int;
		private var _height : int;
		private var _halfW : int;
		private var _halfH : int;
		private var _radius : int;

		private function model_changeHandler(event : Event) : void {
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

		public function CDEffect() {
			mouseEnabled = mouseChildren = false;
			_texture = ASSkin.texture;
			_shadow = new Shape();
			addChild(_shadow);
			_mask = new Shape();
			addChild(_mask);
			_shadow.mask = _mask;
			_model = new RangeModel(0, 360, 360);
			_model.addEventListener(Event.CHANGE, model_changeHandler);
		}

		public function setSize(w : int, h : int) : void {
			_width = w;
			_height = h;
			_halfW = _width * 0.5;
			_halfH = _height * 0.5;
			_radius = MathUtil.getDistance(0, 0, _halfW, _halfH);
			redrawShadow();
			redrawMask();
		}

		public function get model() : RangeModel {
			return _model;
		}
	}
}
