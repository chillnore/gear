package gear.gui.bd {
	import flash.display.Bitmap;
	import flash.filters.ColorMatrixFilter;

	import gear.core.IDispose;
	import gear.gui.core.GBase;
	import gear.log4a.GLogger;
	import gear.pool.GObjPool;
	import gear.render.GFrameRender;
	import gear.render.IGFrame;
	import gear.utils.GColorMatrixUtil;
	import gear.utils.GMathUtil;

	/**
	 * 位图播放器
	 * 
	 * @author bright
	 * @version 20121205
	 */
	public class GBDPlayer extends GBase implements IGFrame,IDispose {
		public static var pool : GObjPool = new GObjPool(GBDPlayer);
		protected var _bitmap : Bitmap;
		protected var _list : GBDList;
		protected var _delay : int;
		protected var _frame : int;
		protected var _frames : Vector.<int>;
		protected var _current : int;
		protected var _offset : int;
		protected var _count : int;
		protected var _loop : int;
		protected var _wait : int;
		protected var _reverse : Boolean;
		protected var _shadow : Bitmap;
		protected var _cmf : ColorMatrixFilter;
		protected var _onChange : Function;
		protected var _onComplete : Function;
		protected var _dirs : int;
		protected var _dir : int;
		protected var _oldDir : int;
		protected var _dirChange : Boolean;
		protected var _isTurn : Boolean;
		protected var _cols : int;

		override protected function preinit() : void {
			_dirs = 1;
			_oldDir = _dir = 0;
			_dirChange = false;
			_isTurn = true;
			enabled = false;
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		override protected function create() : void {
			_bitmap = new Bitmap();
			addChild(_bitmap);
		}

		override protected function onShow() : void {
			if (_current < _frames.length) {
				GFrameRender.instance.add(this);
			}
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		override protected function onHide() : void {
			super.onHide();
			GFrameRender.instance.remove(this);
		}

		protected function resetFrames(value : Vector.<int>) : void {
			_frames.length = 0;
			var total : int;
			var i : int;
			if (value == null || value.length < 1) {
				total = _list.length / _dirs;
				for (i = 0;i < total;i++) {
					_frames.push(i);
				}
			} else {
				total = value.length;
				for (i = 0;i < total;i++) {
					_frames[i] = value[i];
				}
			}
			_offset = 0;
			_current = 0;
			_count = 0;
			_frame = -1;
			_wait = 0;
			_reverse = false;
			update();
		}

		protected function update() : void {
			var frame : int = _frames[_current];
			if (frame < 0 || frame >= _list.length) {
				_frame = -1;
				_bitmap.bitmapData = null;
				if (_shadow != null) {
					_shadow.bitmapData = null;
				}
				return;
			}
			if (_frame == frame) {
				if (_dirChange) {
					_dirChange = false;
				} else {
					return;
				}
			}
			_frame = frame;
			var d : int = _dir;
			if (_isTurn && _oldDir != _dir) {
				d = _oldDir = GMathUtil.getTurnDir(_oldDir, _dir);
			}
			var index : int = d * _cols + _frame;
			var unit : GBDUnit = _list.getAt(index, false);
			if (unit == null) {
				return;
			}
			_bitmap.x = unit.offsetX;
			_bitmap.y = unit.offsetY;
			_bitmap.bitmapData = unit.bd;
			if (_shadow != null) {
				unit = _list.getShadowAt(index, false);
				if (unit != null) {
					_shadow.x = unit.offsetX;
					_shadow.y = unit.offsetY;
					_shadow.bitmapData = unit.bd;
				}
			}
		}

		/**
		 * @inheritDoc
		 */
		public function GBDPlayer() {
			_delay = 80;
			_frames = new Vector.<int>();
		}

		public function get bitmap() : Bitmap {
			return _bitmap;
		}

		public function set list(value : GBDList) : void {
			GFrameRender.instance.remove(this);
			_list = value;
			if (_list == null) {
				if (_bitmap != null) {
					_bitmap.bitmapData = null;
				}
				if (_shadow != null) {
					_shadow.bitmapData = null;
				}
			}
			_frames.length = 0;
			_frame = -1;
			_cols = _list != null ? _list.length / _dirs : 0;
		}

		public function get list() : GBDList {
			return _list;
		}

		public function set delay(delay : int) : void {
			_delay = delay;
			if (_delay < 33) {
				_delay = 33;
			}
			_offset = 0;
		}

		public function get delay() : int {
			return _delay;
		}

		public function set frames(value : Vector.<int>) : void {
			resetFrames(value);
			if (_frames.length > 1) {
				GFrameRender.instance.add(this);
			} else {
				GFrameRender.instance.remove(this);
			}
		}

		public function get frames() : Vector.<int> {
			return _frames;
		}

		public function get loop() : int {
			return _loop;
		}

		public function play(delay : int = 33, frames : Vector.<int> = null, loop : int = 1) : void {
			if (_list == null) {
				return;
			}
			_delay = delay;
			if (_delay < 33) {
				_delay = 33;
			}
			resetFrames(frames);
			_loop = loop;
			if (_frames.length > 1) {
				GFrameRender.instance.add(this);
			} else {
				GFrameRender.instance.remove(this);
			}
		}

		public function playBy(value : GPlayData) : void {
			if (_list == null) {
				return;
			}
			_delay = value.delay;
			if (_delay < 33) {
				_delay = 33;
			}
			resetFrames(value.frames);
			_loop = value.loop;
			_onChange = value.change;
			_onComplete = value.complete;
			if (_frames.length > 1) {
				GFrameRender.instance.add(this);
			} else {
				GFrameRender.instance.remove(this);
				if (_onChange is Function) {
					try {
						_onChange(this);
					} catch(e : Error) {
						GLogger.error(e.getStackTrace());
					}
				}
			}
		}

		public function set wait(value : int) : void {
			_wait = value;
		}

		public function get wait() : int {
			return _wait;
		}

		/**
		 * 重放
		 */
		public function replay() : void {
			_offset = 0;
			_current = 0;
			_count = 0;
			_frame = -1;
			_wait = 0;
			_reverse = false;
			update();
			if (_frames.length > 1) {
				GFrameRender.instance.add(this);
			} else {
				GFrameRender.instance.remove(this);
			}
		}

		/**
		 * 停止位图动画
		 */
		public function stop() : void {
			GFrameRender.instance.remove(this);
		}

		public function get isPlay() : Boolean {
			return GFrameRender.instance.has(this);
		}

		/**
		 * 前一帧
		 */
		public function prevFrame() : void {
			GFrameRender.instance.remove(this);
			if (_current < 1) {
				return;
			}
			_current--;
			update();
		}

		/**
		 * 后一帧
		 */
		public function nextFrame() : void {
			GFrameRender.instance.remove(this);
			if (_current >= _frames.length - 1) {
				return;
			}
			_current++;
			update();
		}

		/**
		 * 修改帧
		 */
		public function changeFrames(index : int, frames : Array) : void {
			if (index < 0 || index >= _frames.length) {
				return;
			}
			for (var i : int = 0;i < frames.length;i++) {
				_frames[index + i] = frames[i];
			}
		}

		/**
		 * 修改播放中的帧，插入帧序列
		 */
		public function insertFrames(index : int, frames : Vector.<int>) : void {
			if (index < 0 || index >= _frames.length || frames == null) {
				return;
			}
			for each (var frame:int in frames) {
				_frames.splice(index, 0, frame);
			}
		}

		/**
		 * 设置动画帧
		 * 
		 * @param frame 帧数
		 */
		public function set current(value : int) : void {
			GFrameRender.instance.remove(this);
			if (_list == null) {
				return;
			}
			if (_frames.length == 0) {
				var total : int = _list.length;
				for (var i : int = 0;i < total;i++) {
					_frames.push(i);
				}
				_frame = -1;
			}
			value = GMathUtil.clamp(value, 0, _frames.length - 1);
			_current = value;
			update();
		}

		public function get current() : int {
			return _current;
		}

		/**
		 * 获得当前帧
		 * 
		 * @return 当前帧
		 */
		public function get frame() : int {
			return _frame;
		}

		public function get unit() : GBDUnit {
			return _list != null ? _list.getAt(_frame, false) : null;
		}

		/**
		 * 获得总帧数
		 * 
		 * @return 总帧数
		 */
		public function get total() : int {
			return _frames.length;
		}

		public function set shadow(value : Bitmap) : void {
			_shadow = value;
		}

		public function adjustColor(b : int = 0, c : int = 0, s : int = 0, h : int = 0) : void {
			if (_cmf == null) {
				_cmf = new ColorMatrixFilter();
			}
			_cmf.matrix = GColorMatrixUtil.adjustColor(b, c, s, h);
			_bitmap.filters = [_cmf];
		}

		public function clearAdjustColor() : void {
			_bitmap.filters = null;
		}

		public function set onChange(value : Function) : void {
			_onChange = value;
		}

		public function get onChange() : Function {
			return _onChange;
		}

		public function set onComplete(value : Function) : void {
			_onComplete = value;
		}

		public function get onComplete() : Function {
			return _onComplete;
		}

		public function refresh() : void {
			if (_wait > 0) {
				_wait--;
				return;
			}
			if (_delay > 33) {
				_offset += GFrameRender.elapsed;
				if (_offset < _delay) {
					return;
				}
				_offset -= _delay;
				_offset %= _delay;
			}
			if (_current >= _frames.length - 1) {
				if (_loop > 0) {
					_count++;
					if (_count >= _loop) {
						GFrameRender.instance.remove(this);
						if (_onComplete != null) {
							try {
								_onComplete(this);
							} catch(e : Error) {
								GLogger.error(e.getStackTrace());
							}
						}
						return;
					}
				}
				_current = 0;
			} else {
				_current++;
			}
			update();
			if (_onChange is Function) {
				try {
					_onChange(this);
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
		}

		/**
		 * 翻转帧数组
		 */
		public function set reverse(value : Boolean) : void {
			if (_reverse == value) {
				return;
			}
			_reverse = value;
			_frames.reverse();
			_current = _frames.length - 1 - _current;
		}

		public function get reverse() : Boolean {
			return _reverse;
		}

		/**
		 * 0 无方向
		 * 1 两方向需翻转
		 * 2 两方向不翻转
		 * 3 四方向需翻转
		 * 4 四方向不翻转
		 * 5 八方向需翻转
		 * 8 八方向不翻转
		 */
		public function set dirs(value : int) : void {
			_dirs = value;
		}

		public function get dirs() : int {
			return _dirs;
		}

		/**
		 * 设置方向值 
		 */
		public function set dir(value : int) : void {
			value = value % 8;
			if (value < 0) {
				value += 8;
			}
			if (_dir == value) {
				return;
			}
			_oldDir = _dir;
			_dir = value;
			_dirChange = true;
			if (_list != null && _frames.length > 0) {
				update();
			}
		}

		public function get dir() : int {
			return _dir;
		}

		/**
		 * 销毁
		 */
		public function dispose() : void {
			GFrameRender.instance.remove(this);
			_bitmap.bitmapData = null;
			if (_shadow != null) {
				_shadow.bitmapData = null;
			}
			_list = null;
		}
	}
}