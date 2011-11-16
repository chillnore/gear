package gear.ui.bd {
	import gear.core.IDispose;
	import gear.log4a.GLogger;
	import gear.render.BDList;
	import gear.render.BDUnit;
	import gear.render.FrameRender;
	import gear.render.IFrame;
	import gear.ui.core.GBase;
	import gear.ui.core.GBaseData;
	import gear.utils.MathUtil;

	import flash.display.Bitmap;

	/**
	 * 位图播放器
	 * 
	 * @author bright
	 * @version 20111017
	 * @example
	 * <listing version="3.0">
	 * var data : GComponentData = new GComponentData();
	 * var breath_bp:BDPlayer = new BDPlayer(data);
	 * addChild(breath_bp);
	 * breath_bp.list=BDUtil.getBDList(new AssetData("breath","avatar"));
	 * breath_bp.play(300, [0, 1, 0, 1, 2, 1, 0, 1, 0, 1, 2, 1, 3, 4], 0);
	 * </listing>
	 */
	public final class BDPlayer extends GBase implements IFrame,IDispose {
		private var _bitmap : Bitmap;
		private var _list : BDList;
		private var _delay : int;
		private var _frame : int;
		private var _target : Array;
		private var _frames : Array;
		private var _current : int;
		private var _offset : int;
		private var _count : int;
		private var _loop : int;
		private var _shadow : Bitmap;
		private var _onChange : Function;
		private var _onComplete : Function;
		private var _flipH : Boolean;

		/**
		 * @private
		 * @inheritDoc
		 */
		override protected function create() : void {
			_bitmap = new Bitmap();
			addChild(_bitmap);
		}

		/**
		 * @private
		 * @inheritDoc
		 */
		override protected function onHide() : void {
			super.onHide();
			stop();
		}

		private function goto(frame : int) : void {
			if (frame < 0 || frame >= _list.total) {
				_frame = -1;
				_bitmap.bitmapData = null;
				return;
			}
			if (_frame == frame) {
				return;
			}
			_frame = frame;
			var unit : BDUnit = _list.getAt(_frame, _flipH);
			if (unit == null) {
				return;
			}
			_bitmap.x = unit.offsetX;
			_bitmap.y = unit.offsetY;
			_bitmap.bitmapData = unit.bd;
			_bitmap.smoothing = true;
			if (_shadow != null) {
				unit = _list.getShadowAt(_frame, _flipH);
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
		public function BDPlayer(base : GBaseData = null) {
			if (base == null) {
				base = new GBaseData();
			}
			super(base);
			_delay = 80;
			_flipH = false;
		}

		public function set list(value : BDList) : void {
			FrameRender.instance.remove(this);
			_list = value;
		}

		public function get list() : BDList {
			return _list;
		}

		public function play(delay : int = 33, frames : Array = null, loop : int = 1) : void {
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
			_frame = -1;
			if (_list == null) {
				return;
			}
			goto(_frames[_current]);
			if (_frames.length > 1) {
				FrameRender.instance.add(this);
			}
		}

		public function set frames(value : Array) : void {
			_frames = value;
		}

		public function changeFrames(index : int, frames : Array) : void {
			if (index < 0 || index >= _frames.length) {
				return;
			}
			for (var i : int = 0;i < frames.length;i++) {
				_frames[index + i] = frames[i];
			}
		}

		public function get frames() : Array {
			return _frames;
		}

		/**
		 * 停止位图动画
		 */
		public function stop() : void {
			FrameRender.instance.remove(this);
		}

		/**
		 * 设置动画帧
		 * 
		 * @param frame 帧数
		 */
		public function set current(value : int) : void {
			if (_list == null) {
				return;
			}
			stop();
			value = MathUtil.clamp(value, 0, _frames.length - 1);
			_current = value;
			goto(_frames[_current]);
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

		/**
		 * 获得总帧数
		 * 
		 * @return 总帧数
		 */
		public function get total() : int {
			return _frames.length;
		}

		/**
		 * 是否翻转
		 * 
		 * @param value ture翻转false不翻转
		 */
		public function set flipH(value : Boolean) : void {
			_flipH = value;
		}

		public function get flipH() : Boolean {
			return _flipH;
		}

		public function set shadow(value : Bitmap) : void {
			_shadow = value;
		}

		public function set onChange(value : Function) : void {
			_onChange = value;
		}

		public function set onComplete(value : Function) : void {
			_onComplete = value;
		}

		public function refresh() : void {
			if (_delay > 33) {
				_offset += FrameRender.elapsed;
				if (_offset < _delay) {
					return;
				}
				_offset -= _delay;
				_offset %= _delay;
			}
			_current++;
			if (_current == _frames.length) {
				_current = 0;
				if (_loop > 0) {
					_count++;
					if (_count == _loop) {
						FrameRender.instance.remove(this);
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
			}
			goto(_frames[_current]);
			if (_onChange is Function) {
				try {
					_onChange(this);
				} catch(e : Error) {
					GLogger.error(e.getStackTrace());
				}
			}
		}

		/**
		 * 销毁
		 */
		public function dispose() : void {
			FrameRender.instance.remove(this);
			_bitmap.bitmapData = null;
			_list = null;
			_frames = null;
		}

		/**
		 * 克隆
		 * @return 克隆
		 */
		public function clone() : BDPlayer {
			var data : GBaseData = _base.clone();
			var player : BDPlayer = new BDPlayer(data);
			return player;
		}
	}
}