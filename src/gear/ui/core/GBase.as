package gear.ui.core {
	import gear.ui.layout.GLayout;
	import gear.ui.manager.GUIUtil;
	import gear.utils.GMathUtil;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * Game UI基类
	 * 
	 * @author bright
	 * @version 20121105
	 */
	public class GBase extends Sprite {
		public static const SHOW : String = "show";
		public static const HIDE : String = "hide";
		protected var _base : GBaseData;
		protected var _enabled : Boolean;
		protected var _width : int;
		protected var _height : int;
		protected var _renders : Vector.<Function>;
		protected var _source : *;

		protected function addToStageHandler(event : Event) : void {
			if (parent == GUIUtil.root) {
				stage.addEventListener(Event.RESIZE, resizeHandler);
			} else {
				parent.addEventListener(Event.RESIZE, resizeHandler);
			}
			stage.addEventListener(Event.RENDER, renderHandler);
			if (_renders.length > 0) {
				stage.invalidate();
			}
			onShow();
			dispatchEvent(new Event(SHOW));
		}

		protected function removedFromStageHandler(event : Event) : void {
			stage.removeEventListener(Event.RENDER, renderHandler);
		}

		private function resizeHandler(event : Event) : void {
			addRender(onResize);
		}

		protected function renderHandler(event : Event) : void {
			render();
		}

		protected function addRender(value : Function) : void {
			if (_renders.indexOf(value) != -1) {
				return;
			}
			_renders.push(value);
			if (stage != null) {
				stage.invalidate();
			}
		}

		/**
		 * 初始化
		 * 
		 * @private
		 */
		protected function init() : void {
			_renders = new Vector.<Function>();
			create();
			alpha = _base.alpha;
			visible = _base.visible;
			moveTo(_base.x, _base.y);
			setSize(_base.width, _base.height);
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		/**
		 * @private 创建
		 */
		protected function create() : void {
		}

		/**
		 * @private 布局
		 */
		protected function layout() : void {
		}

		protected function onResize() : void {
			GLayout.layout(this);
		}

		protected function onEnabled() : void {
		}

		/**
		 * @private 当显示时
		 */
		protected function onShow() : void {
		}

		/**
		 * @private 当隐藏时
		 */
		protected function onHide() : void {
		}

		public function GBase(base : GBaseData) {
			_base = base;
			init();
		}

		public function set align(value : GAlign) : void {
			_base.align = value;
		}

		public function get align() : GAlign {
			return _base.align;
		}

		/**
		 * 移动到指定坐标
		 * 
		 * @param newX 新的X坐标
		 * @param newY 新的Y坐标
		 */
		public function moveTo(newX : int, newY : int) : void {
			x = newX;
			y = newY;
		}

		/**
		 * 设置启用状态
		 * 
		 * @param value 启用状态
		 */
		public function set enabled(value : Boolean) : void {
			if (_enabled == value) {
				return;
			}
			_enabled = value;
			mouseEnabled = mouseChildren = _enabled;
			onEnabled();
		}

		public function render() : void {
			var update : Function;
			while (_renders.length > 0) {
				update = _renders.shift();
				update.apply();
			}
		}

		/**
		 * setSize 设置尺寸
		 * 
		 * @param w int 宽度
		 * @param h int 高度
		 */
		public function setSize(w : int, h : int) : void {
			var oldW : int = _width;
			var oldH : int = _height;
			width = w;
			height = h;
			if (oldW != _width || oldH != _height) {
				dispatchEvent(new Event(Event.RESIZE));
			}
		}

		/**
		 * 设置宽度
		 * 
		 * @param value 宽度
		 */
		override public function set width(value : Number) : void {
			if (_base.scaleMode == GScaleMode.NONE || _base.scaleMode == GScaleMode.AUTO_SIZE) {
				return;
			}
			if (_base.scaleMode == GScaleMode.AUTO_HEIGHT) {
				return;
			}
			var newW : int = GMathUtil.clamp(Math.round(value), _base.minWidth, _base.maxWidth);
			if (_width == newW) {
				return;
			}
			_width = newW;
			addRender(layout);
		}

		/**
		 * 设置高度
		 * 
		 * @param value 高度
		 */
		override public function set height(value : Number) : void {
			if (_base.scaleMode == GScaleMode.NONE || _base.scaleMode == GScaleMode.AUTO_SIZE ) {
				return;
			}
			if (_base.scaleMode == GScaleMode.AUTO_WIDTH) {
				return;
			}
			var newH : int = GMathUtil.clamp(Math.round(value), _base.minHeight, _base.maxHeight);
			if (_height == newH) {
				return;
			}
			_height = newH;
			addRender(layout);
		}

		/**
		 * 显示组件
		 */
		public function show() : void {
			if (_base.parent == null) {
				return;
			}
			if (parent != null) {
				parent.setChildIndex(this, parent.numChildren - 1);
			} else {
				_base.parent.addChild(this);
			}
		}

		/**
		 * 隐藏组件
		 */
		public function hide() : void {
			if (parent == null) {
				return;
			}
			if (_base.parent == null) {
				_base.parent = parent;
			}
			parent.removeChild(this);
		}

		public function switchShow() : void {
			if (parent == null) {
				show();
			} else {
				hide();
			}
		}

		/**
		 * 设置数据源
		 * 
		 * @param value 数据源
		 */
		public function set source(value : *) : void {
			_source = value;
		}

		/**
		 * 获得数据源
		 * 
		 * @return 数据源
		 */
		public function get source() : * {
			return _source;
		}
	}
}
