/**
 *
 *
 *	ScaleBitmapSprite
 *	
 *	@author		Didier Brun
 *	@author 	Jerôme Decoster
 *	@version	1.1
 *
 */
package gear.ui.bd {
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;

	public class ScaleBitmapSprite extends Sprite {
		private var _bitmapData : BitmapData;
		private var _height : Number;
		private var _width : Number;
		private var _inner : Rectangle;
		private var _minHeight : Number;
		private var _minWidth : Number;
		private var _outer : Rectangle;
		private var _outerHeight : Number;
		private var _outerWidth : Number;
		private var _smooth : Boolean;

		/**
		 * @param bitmapData BitmapData source
		 * @param inner Inner rectangle (relative to 0,0)
		 * @param outer Outer rectangle (relative to 0,0)
		 * @param smooth If <code>false</code>, upscaled bitmap images are rendered by using a nearest-neighbor 
		 * algorithm and look pixelated. If <code>true</code>, upscaled bitmap images are rendered by using a 
		 * bilinear algorithm. Rendering by using the nearest neighbor algorithm is usually faster.
		 */
		function ScaleBitmapSprite(bitmapData : BitmapData, inner : Rectangle, outer : Rectangle = null, smooth : Boolean = false) {
			_bitmapData = bitmapData;
			_inner = inner;
			_outer = outer;
			_smooth = smooth;

			if (outer != null) {
				_width = outer.width;
				_height = outer.height;
				_outerWidth = bitmapData.width - outer.width;
				_outerHeight = bitmapData.height - outer.height;
			} else {
				_width = inner.width;
				_height = inner.height;
				_outerWidth = 0;
				_outerHeight = 0;
			}
			_minWidth = bitmapData.width - inner.width - _outerWidth + 2;
			_minHeight = bitmapData.height - inner.height - _outerHeight + 2;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		// --------------------------------------
		// EVENTS
		// --------------------------------------
		private function onAddedToStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			addEventListener(Event.RENDER, onRender);
			onRender();
		}

		private function onRemovedFromStage(event : Event) : void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			removeEventListener(Event.RENDER, onRender);
		}

		private function onRender(event : Event = null) : void {
			graphics.clear();
			ScaleBitmap.draw(_bitmapData, graphics, (_width + _outerWidth) >> 0, (_height + _outerHeight) >> 0, _inner, _outer,_smooth);
		}

		// --------------------------------------
		// PUBLIC
		// --------------------------------------
		/**
		 * setter deactivated
		 */
		override public function set scaleX(value : Number) : void {
		}

		/**
		 * setter deactivated
		 */
		override public function set scaleY(value : Number) : void {
		}

		/**
		 * @inheritDoc
		 */
		override public function get width() : Number {
			return _width;
		}

		/**
		 * @inheritDoc
		 */
		override public function set width(value : Number) : void {
			_width = value > _minWidth ? value : _minWidth;
			onRender();
		}

		/**
		 * @inheritDoc
		 */
		override public function get height() : Number {
			return _height;
		}

		/**
		 * @inheritDoc
		 */
		override public function set height(value : Number) : void {
			_height = value > _minHeight ? value : _minHeight;
			onRender();
		}

		/**
		 * The BitmapData object being referenced.
		 */
		public function get bitmapData() : BitmapData {
			return _bitmapData;
		}

		public function set bitmapData(value : BitmapData) : void {
			_bitmapData = value;
			if (stage != null) stage.invalidate();
		}
	}
}