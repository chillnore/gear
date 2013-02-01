package gear.effect {
	import gear.utils.GMathUtil;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class GWood extends Sprite {
		private var _perlin_bd : BitmapData;
		private var _width : Number;
		private var _height : Number;
		private var _bd : BitmapData;
		private var _bp : Bitmap;
		private var _blur : BlurFilter;
		private var _rArray : Array;
		private var _gArray : Array;
		private var _bArray : Array;
		private var _sourceSprite : DisplayObject;
		private var _source_bd : BitmapData;
		private var _source_bp : Bitmap;
		private var _woodPattern_bd : BitmapData;
		private var _scale : Number;
		private var _inGlow : GlowFilter;
		public var colorList : Vector.<uint>;
		public var perlinBaseX : int;
		public var perlinBaseY : int;
		public var roundingAmount : Number;
		public var roundingSize : Number;

		private function setFilter() : void {
			if (roundingAmount != 0) {
				_inGlow = new GlowFilter(0x000000, roundingAmount, roundingSize, roundingSize, 2, 3, true, false);
				_bp.filters = [_inGlow];
			} else {
				_bp.filters = [];
			}
		}

		private function mapWoodToDisplay() : void {
			_bd.draw(_woodPattern_bd, new Matrix(1 / _scale, 0, 0, 1 / _scale), null, null, null, true);
			_bd.copyChannel(_source_bd, _source_bd.rect, new Point(), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
		}

		private function setColorThresholds() : void {
			var numBands : int = 80;
			var r : uint;
			var g : uint;
			var b : uint;
			var i : int;
			var index : int;
			var color : uint;
			var rInitArray : Array = new Array();
			var gInitArray : Array = new Array();
			var bInitArray : Array = new Array();
			_rArray = new Array();
			_gArray = new Array();
			_bArray = new Array();
			var colorChoices : Vector.<uint> = new Vector.<uint>();
			var len : int = colorList.length;
			for (i = 0; i < len; i++) {
				var thisColor : uint = colorList[i];
				colorChoices.push(thisColor);
			}
			var choiceIndex : int;
			var lastChoice : uint = colorChoices.splice(0, 1)[0];
			for (i = 0; i <= numBands; i++) {
				choiceIndex = Math.floor(Math.random() * colorChoices.length);
				color = colorChoices[choiceIndex];
				r = color & 0xFF0000;
				g = color & 0xFF00;
				b = color & 0xFF;
				rInitArray.push(r);
				gInitArray.push(g);
				bInitArray.push(b);
				colorChoices.splice(choiceIndex, 1);
				colorChoices.push(lastChoice);
				lastChoice = color;
			}
			for (i = 0; i <= 255; i++) {
				index = int(i / 255 * (numBands - 1));
				_rArray.push(rInitArray[index]);
				_gArray.push(gInitArray[index]);
				_bArray.push(bInitArray[index]);
			}
		}

		private function makeRegularColorBands() : void {
			_woodPattern_bd.paletteMap(_perlin_bd, _perlin_bd.rect, GMathUtil.ZERO_POINT, _rArray, _gArray, _bArray);
		}

		private function fillPerlinNoise() : void {
			_perlin_bd.perlinNoise(perlinBaseX, perlinBaseY, 4, Math.random() * 10, false, true, 7, true);
			_perlin_bd.applyFilter(_perlin_bd, _perlin_bd.rect, new Point(), new BlurFilter(6, 6));
		}

		public function GWood(inputSprite : DisplayObject) : void {
			_sourceSprite = inputSprite;
			var bounds : Rectangle = _sourceSprite.getBounds(_sourceSprite);
			_width = bounds.width;
			_height = bounds.height;
			_source_bd = new BitmapData(_width, _height, true, 0x00000000);
			_source_bp = new Bitmap(_source_bd);
			_source_bd.draw(_sourceSprite, new Matrix(1, 0, 0, 1, -bounds.x, -bounds.y), null, null, null, true);
			addChild(_sourceSprite);
			_sourceSprite.alpha = 0;
			roundingAmount = 0.4;
			roundingSize = 6;
			_scale = 2;
			perlinBaseX = 50;
			perlinBaseY = 600;
			_woodPattern_bd = new BitmapData(_scale * _width, _scale * _height, true, 0x00000000);
			_perlin_bd = new BitmapData(_scale * _width, _scale * _height, false, 0x000000);
			_bd = new BitmapData(_width, _height, true, 0x00000000);
			_bp = new Bitmap(_bd);
			_bp.x = bounds.x;
			_bp.y = bounds.y;
			addChild(_bp);
			_blur = new BlurFilter(2, 2);
			colorList = new <uint>[0xd78e41, 0xd8994a, 0xcc7d38, 0xb86a2c, 0xae531c];
		}

		public function generate() : void {
			setColorThresholds();
			fillPerlinNoise();
			makeRegularColorBands();
			mapWoodToDisplay();
			setFilter();
		}
	}
}