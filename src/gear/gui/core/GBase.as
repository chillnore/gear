package gear.gui.core {
	import gear.utils.GNameUtil;
	import gear.gui.utils.GUIUtil;
	import gear.utils.GMathUtil;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * 控件基类
	 * 
	 * @author bright
	 * @version 20130325
	 */
	public class GBase extends Sprite implements IGBase {
		protected var _parent : DisplayObjectContainer;
		protected var _width : int;
		protected var _height : int;
		protected var _minWidth : int;
		protected var _minHeight : int;
		protected var _maxWidth : int;
		protected var _maxHeight : int;
		protected var _scaleMode : int;
		protected var _autoSize : int;
		protected var _align : GAlign;
		protected var _enabled : Boolean;
		protected var _padding : GPadding;
		protected var _events : Vector.<Object>;
		protected var _methods : Vector.<Function>;
		protected var _isRender : Boolean;
		protected var _sizeRender : Boolean;
		protected var _source : *;

		protected final function addToStageHandler(event : Event) : void {
			if (parent == stage || parent == stage.loaderInfo.content) {
				parent.setChildIndex(this, parent.numChildren - 1);
				addEvent(stage, Event.RESIZE, stageResizeHandler);
			}
			if (!_isRender && _methods.length > 0 && stage != null) {
				addEvent(this, Event.ENTER_FRAME, renderHandler);
				addEvent(this, Event.RENDER, renderHandler);
				stage.invalidate();
			}
			onShow();
		}

		protected final function removedFromStageHandler(event : Event) : void {
			removeAllEvent();
			onHide();
		}

		protected final function stageResizeHandler(event : Event) : void {
			if (_align != null) {
				callLater(layout);
			}
			onStageResize();
		}

		protected final function renderHandler(event : Event) : void {
			render();
		}

		protected final function render() : void {
			if (_isRender || _methods.length < 1) {
				return;
			}
			_isRender = true;
			var method : Function;
			while (_methods.length > 0) {
				method = _methods.shift();
				method.apply();
			}
			removeEvent(this, Event.ENTER_FRAME);
			removeEvent(this, Event.RENDER);
			_isRender = false;
		}

		protected final function addEvent(target : IEventDispatcher, type : String, listener : Function) : void {
			var event : Object;
			for each (event in _events) {
				if (event.target == target && event.type == type) {
					return;
				}
			}
			target.addEventListener(type, listener);
			_events.push({target:target, type:type, listener:listener});
		}

		protected final function removeEvent(target : IEventDispatcher, type : String) : void {
			var event : Object;
			for (var i : int = 0; i < _events.length; i++) {
				event = _events[i];
				if (event.target == target && event.type == type) {
					EventDispatcher(event.target).removeEventListener(event.type, event.listener);
					_events.splice(i, 1);
					break;
				}
			}
		}

		protected final function removeAllEvent() : void {
			for each (var event : Object in _events) {
				EventDispatcher(event.target).removeEventListener(event.type, event.listener);
			}
			_events.length = 0;
		}

		protected final function callLater(value : Function) : void {
			var index : int = _methods.indexOf(value);
			if (index != -1) {
				return;
			}
			_methods.push(value);
			if (!_isRender && _methods.length > 0 && stage != null) {
				addEvent(this, Event.ENTER_FRAME, renderHandler);
				addEvent(this, Event.RENDER, renderHandler);
				stage.invalidate();
			}
		}

		protected function init() : void {
			_maxWidth = 2880;
			_maxHeight = 1880;
			_scaleMode = GScaleMode.SCALE;
			_autoSize = GAutoSize.NONE;
			_enabled = true;
			_padding = new GPadding();
			_events = new Vector.<Object>();
			_methods = new Vector.<Function>();
			_isRender = false;
			name = GNameUtil.createUniqueName(this);
			preinit();
			create();
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		protected function preinit() : void {
		}

		protected function create() : void {
		}

		protected function resize() : void {
		}

		protected function layout() : void {
			GAlignLayout.layout(this);
		}

		protected function onStageResize() : void {
		}

		protected function onEnabled() : void {
		}

		protected function onShow() : void {
		}

		protected function onHide() : void {
		}

		protected function forceSize(newW : int, newH : int) : void {
			if (_width != newW || _height != newH) {
				_width = newW;
				_height = newH;
			}
		}

		public function GBase() {
			init();
		}

		public function get methods() : int {
			return _methods.length;
		}

		public function setParent(value : DisplayObjectContainer) : void {
			_parent = value;
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

		public function moveTo(newX : int, newY : int) : void {
			x = newX;
			y = newY;
		}

		/**
		 * 设置最小尺寸
		 */
		public function setMinSize(newW : int, newH : int) : void {
			_minWidth = newW;
			_minHeight = newH;
		}

		/**
		 * 设置最大尺寸
		 */
		public function setMaxSize(newW : int, newH : int) : void {
			_maxWidth = newW;
			_maxHeight = newH;
		}

		public function setSize(newW : int, newH : int) : void {
			width = newW;
			height = newH;
		}

		override public function set width(value : Number) : void {
			if (_scaleMode == GScaleMode.FIT_SIZE || _scaleMode == GScaleMode.FIT_WIDTH || _autoSize == GAutoSize.AUTO_SIZE || _autoSize == GAutoSize.AUTO_WIDTH) {
				return;
			}
			var newW : int = GMathUtil.clamp(GMathUtil.round(value), _minWidth, _maxWidth);
			if (_width == newW) {
				return;
			}
			_width = newW;
			callLater(resize);
		}

		override public function get width() : Number {
			if (_sizeRender) {
				render();
			}
			return _width;
		}

		public function get right() : int {
			return x + width;
		}

		public function get bottom() : int {
			return y + height;
		}

		override public function set height(value : Number) : void {
			if (_scaleMode == GScaleMode.FIT_SIZE || _scaleMode == GScaleMode.FIT_HEIGHT || _autoSize == GAutoSize.AUTO_SIZE || _autoSize == GAutoSize.AUTO_HEIGHT) {
				return;
			}
			var newH : int = GMathUtil.clamp(GMathUtil.round(value), _minHeight, _maxHeight);
			if (_height == newH) {
				return;
			}
			_height = newH;
			callLater(resize);
		}

		override public function get height() : Number {
			if (_sizeRender) {
				render();
			}
			return _height;
		}

		public function set scaleMode(value : int) : void {
			if (_scaleMode == value) {
				return;
			}
			_scaleMode = value;
		}

		public function set autoSize(value : int) : void {
			if (_autoSize == value) {
				return;
			}
			_autoSize = value;
		}

		public function get align() : GAlign {
			return _align;
		}

		public function set align(value : GAlign) : void {
			_align = value;
			if (_align != null) {
				callLater(layout);
			}
		}

		public function get padding() : GPadding {
			return _padding;
		}

		/**
		 * 显示组件
		 */
		public function show() : void {
			if (parent != null) {
				parent.setChildIndex(this, parent.numChildren - 1);
			} else {
				if (_parent == null) {
					_parent = GUIUtil.stage;
				}
				if (_parent != null) {
					_parent.addChild(this);
				}
			}
		}

		/**
		 * 隐藏组件
		 */
		public function hide() : void {
			if (parent == null) {
				return;
			}
			if (_parent == null) {
				_parent = parent;
			}
			parent.removeChild(this);
		}

		/**
		 * 切换显示/隐藏
		 */
		public function switchSelf() : void {
			parent == null ? show() : hide();
		}

		public function set source(value : *) : void {
			_source = value;
		}

		public function get source() : * {
			return _source;
		}
	}
}
