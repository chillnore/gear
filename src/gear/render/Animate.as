package gear.render {
	import flash.display.BitmapData;
	import flash.filters.BitmapFilter;
	import flash.geom.Point;
	import gear.log4a.GLogger;
	import gear.utils.MathUtil;


	/**
	 * @author Administrator
	 */
	public class Animate extends Render2C {
		protected var _delay : int;
		protected var _current : int;
		protected var _frames : Array;
		protected var _target : Array;
		protected var _offset : int;
		protected var _count : int;
		protected var _loop : int;
		protected var _list : BDList;
		protected var _pause : Boolean;
		protected var _onChange : Function;
		protected var _onComplete : Function;
		protected var _shadow : Point;
		protected var _buffer : BitmapData;

		protected function renderFrame(target : BitmapData, cx : int, cy : int) : void {
			var frame : int = _frames[_current];
			var unit : BDUnit;
			var px : int = (_parent != null ? _parent.x : 0) - cx;
			var py : int = (_parent != null ? _parent.y : 0) - cy;
			if (_list.hasShadow) {
				unit = _list.getShadowAt(frame, _flipH);
				if (unit != null) {
					_dest.x = px + _shadow.x + unit.rect.x;
					_dest.y = py + _shadow.y + unit.rect.y;
					target.copyPixels(unit.bd, unit.bd.rect, _dest, null, null, true);
				}
			}
			unit = _list.getAt(frame, _flipH);
			if (unit != null) {
				_dest.x = px + _x + unit.rect.x;
				_dest.y = py + _y + unit.rect.y;
				if (_scaleX != 1 || _scaleY != 1 || _alpha != 1) {
					_matrix.identity();
					_matrix.scale(_scaleX, _scaleY);
					_matrix.tx = _dest.x;
					_matrix.ty = _dest.y;
					target.draw(unit.bd, matrix, _ctf, null, null, true);
					return;
				}
				if (_filters != null) {
					if (_buffer != null) {
						_buffer.dispose();
					}
					_buffer = unit.bd.clone();
					for each (var filter:BitmapFilter in _filters) {
						_buffer.applyFilter(_buffer, _buffer.rect, MathUtil.ZERO_POINT, filter);
					}
					target.copyPixels(_buffer, _buffer.rect, _dest, null, null, true);
					return;
				}
				target.copyPixels(unit.bd, unit.bd.rect, _dest, null, null, true);
			}
		}

		public function Animate() : void {
			_pause = false;
			_shadow = new Point();
		}

		public function get current() : int {
			return _current;
		}

		public function get total() : int {
			return _frames.length;
		}

		public function set list(value : BDList) : void {
			_list = value;
		}

		public function get list() : BDList {
			return _list;
		}

		public function changeFrames(index : int, frames : Array) : void {
			if (index < 0 || index >= _frames.length) {
				return;
			}
			for (var i : int = 0;i < frames.length;i++) {
				_frames[index + i] = frames[i];
			}
		}

		public function setTo(delay : int, frames : Array, loop : int = 1) : void {
			if (delay < 33) {
				_delay = 33;
			} else {
				_delay = delay;
			}
			_target = frames;
			if (_target == null) {
				_target = new Array();
				var total : int = _list.total;
				for (var i : int = 0;i < total;i++) {
					_target.push(i);
				}
			}
			_frames = _target.concat();
			_loop = loop;
			_offset = 0;
			_current = 0;
			_count = 0;
			_pause = _frames.length < 2;
		}

		public function set onChange(value : Function) : void {
			_onChange = value;
		}

		public function set onComplete(value : Function) : void {
			_onComplete = value;
		}

		public function set pause(value : Boolean) : void {
			_pause = value;
		}

		override public function render(target : BitmapData, ox : int, oy : int) : void {
			if (_pause) {
				renderFrame(target, ox, oy);
				return;
			}
			if (_delay > 33) {
				_offset += FrameRender.elapsed;
				if (_offset < _delay) {
					renderFrame(target, ox, oy);
					return;
				}
				_offset -= _delay;
				_offset %= _delay;
			}
			if (_current == _frames.length - 1) {
				if (_loop > 0) {
					if (_count == _loop - 1) {
						if (_onChange is Function) {
							try {
								_onChange(this);
							} catch(e : Error) {
								GLogger.error(e.getStackTrace());
							}
						}
						if (_onComplete is Function) {
							try {
								_onComplete(this);
							} catch(e : Error) {
								GLogger.error(e.getStackTrace());
							}
						}
						renderFrame(target, ox, oy);
						return;
					}
					_count++;
				}
				_current = 0;
			}
			if (_onChange is Function) {
				try {
					_onChange(this);
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
			renderFrame(target, ox, oy);
			_current++;
		}

		public function get shadow() : Point {
			return _shadow;
		}
	}
}
