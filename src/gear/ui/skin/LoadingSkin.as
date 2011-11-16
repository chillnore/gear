package gear.ui.skin {
	import gear.net.AssetData;
	import gear.net.RESManager;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;

	public class LoadingSkin extends Bitmap {
		private static var textures : Array;
		private var motionFunc : Function;

		private function myMotion() : void {
			var texID : int = 0;
			killMotion();
			texID = 0;
			motionFunc = function(_arg1 : Event) : void {
				bitmapData = textures[texID];
				if (++texID >= textures.length) {
					texID = 0;
				}
			};
			addEventListener(Event.ENTER_FRAME, motionFunc);
		}

		public function init() : void {
			if (textures == null) {
				makeBody();
			}
		}

		private function createTex(_arg1 : Sprite, _arg2 : Array) : void {
			var _local3 : Number;
			var _local4 : int;
			var _local5 : Number;
			var _local6 : Array;
			var _local7 : int;
			var _local8 : int;
			var _local9 : Number;
			var _local10 : Number;
			var _local11 : Shape;
			var _local12 : Matrix;
			var _local13 : int;
			var _local14 : BitmapData;
			textures = [];
			_local3 = 0;
			_local4 = 20;
			_local5 = ((2 * Math.PI) / (_local4 + 0));
			_local6 = _arg2;
			_local8 = _local6.length;
			_local9 = (180 / Math.PI);
			_local10 = ((2 * Math.PI) / _local8);
			_local12 = new Matrix(1, 0, 0, 1, (_arg1.width >> 1), (_arg1.height >> 1));
			_local13 = 0;
			while (_local13 < _local4) {
				_local7 = 0;
				while (_local7 < _local8) {
					_local11 = _local6[_local7];
					_local11.rotation = (_local3 * _local9);
					_local3 = (_local3 + _local10);
					_local7++;
				}
				;
				_local3 = (_local3 + _local5);
				_local14 = new BitmapData(_arg1.width, _arg1.height, true, 0);
				_local14.draw(_arg1, _local12);
				textures[_local13] = _local14;
				_local13++;
			}
			;
			clearShape(_arg1, _arg2);
		}

		public function remove() : void {
			bitmapData = null;
			killMotion();
		}

		private function makeBody() : void {
			var _local1 : Sprite;
			var _local2 : Array;
			var _local3 : int;
			var _local4 : int;
			var _local5 : int;
			var _local6 : Number;
			var _local7 : Number;
			var _local8 : Number;
			var _local9 : Shape;
			var _local10 : Number;
			var _local11 : Number;
			var _local12 : Number;
			var _local13 : BitmapData;
			var _local14 : Number;
			var _local15 : int;
			_local1 = new Sprite();
			_local2 = [];
			_local4 = 20;
			_local5 = (_local4 >> 1);
			_local6 = (180 / Math.PI);
			_local7 = 0;
			_local8 = ((2 * Math.PI) / _local4);
			_local10 = 0.05;
			_local11 = _local10;
			_local12 = (((1 - _local11) / _local4) * 2);
			_local13 = RESManager.getBD(new AssetData("building_tex", "uiLib"));
			_local14 = ((_local13.height - 20) / _local4);
			_local3 = 0;
			while (_local3 < _local4) {
				_local9 = makeShape(_local11, _local13.getPixel(60, ((_local3 * _local14) + 10)));
				_local1.addChild(_local9);
				_local9.rotation = (_local7 * _local6);
				_local7 = (_local7 + _local8);
				if (_local3 == _local5) {
					_local11 = _local10;
				}
				;
				_local11 = (_local11 + _local12);
				_local2[_local3] = _local9;
				_local3++;
			}
			;
			_local1.graphics.beginFill(0xFFFFFF, 1);
			_local15 = 14;
			_local1.graphics.drawCircle(0, 0, _local15);
			_local1.graphics.endFill();
			createTex(_local1, _local2);
			_local1 = null;
			_local2 = null;
		}

		private function killMotion() : void {
			if (motionFunc != null) {
				removeEventListener(Event.ENTER_FRAME, motionFunc);
				motionFunc = null;
			}
		}

		public function clearShape(_arg1 : Sprite, _arg2 : Array) : void {
			var _local3 : int;
			var _local4 : Shape;
			var _local5 : int;
			_arg1.graphics.clear();
			_local3 = _arg2.length;
			_local5 = 0;
			while (_local5 < _local3) {
				_local4 = _arg2[_local5];
				_arg1.removeChild(_local4);
				_local4.graphics.clear();
				_local4 = null;
				delete _arg2[_local5];
				_local5++;
			}
			;
			_arg2 = null;
			_arg1 = null;
		}

		public function showYou() : void {
			bitmapData = textures[0];
			myMotion();
		}

		private function makeShape(_arg1 : Number, _arg2 : int) : Shape {
			var _local3 : Number;
			var _local4 : int;
			var _local5 : int;
			var _local6 : Shape;
			_local3 = 1.2;
			_local4 = 8;
			_local5 = 4;
			_local6 = new Shape();
			_local6.graphics.beginFill(_arg2, _arg1);
			_local6.graphics.moveTo(0, _local5);
			_local6.graphics.lineTo(_local3, (_local4 + _local5));
			_local6.graphics.lineTo(-(_local3), (_local4 + _local5));
			_local6.graphics.lineTo(0, _local5);
			_local6.graphics.endFill();
			return (_local6);
		}
	}
}