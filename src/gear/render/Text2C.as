package gear.render {
	import flash.display.BitmapData;
	import flash.filters.GlowFilter;
	import flash.text.TextField;

	/**
	 * @author bright
	 * @version 20111025
	 */
	public class Text2C extends Render2C {
		protected var _tf : TextField;
		protected var _bd : BitmapData;

		public function Text2C() {
			_tf = new TextField();
			_tf.textColor = 0xFFFFFF;
			_tf.filters = [new GlowFilter(0, 1, 2, 2, 17, 1, false, false)];
		}

		public function set text(value : String) : void {
			_tf.text = value;
			var w : int = _tf.textWidth + 4;
			var h : int = _tf.textHeight + 4;
			if (_bd != null) {
				_bd.dispose();
			}
			_bd = new BitmapData(w, h, true, 0);
			_matrix.identity();
			_matrix.scale(_scaleX, _scaleY);
			_matrix.tx = _dest.x;
			_matrix.ty = _dest.y;
			_bd.draw(_tf, _matrix, _ctf, null, null, true);
		}

		override public function render(target : BitmapData, cx : int, cy : int) : void {
			_dest.x = (_parent != null ? _parent.x : 0) + _x - (_bd.width >> 1) - cx;
			_dest.y = (_parent != null ? _parent.y : 0) + _y - cy;
			target.copyPixels(_bd, _bd.rect, _dest, null, null, true);
		}
	}
}
