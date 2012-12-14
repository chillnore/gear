package gear.gui.containers {
	import gear.gui.core.GAlignLayout;
	import gear.gui.core.GBase;
	import gear.gui.core.GScaleMode;
	import gear.gui.skin.IGSkin;
	import gear.gui.utils.GUIUtil;

	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * 面板控件
	 * 
	 * @author bright
	 * @version 20121204
	 */
	public class GPanel extends GBase {
		protected var _bgSkin:IGSkin;
		protected var _content : Sprite;
		protected var _modalSkin : Sprite;

		override protected function preinit() : void {
			setSize(100, 100);
		}
		
		override protected function create():void{
			_content=new Sprite();
			addChild(_content);
		}

		override protected function resize() : void {
			trace("resize", _width, _height);
			if (_bgSkin != null) {
				_bgSkin.setSize(_width,_height);
			}
			var base : DisplayObject;
			for (var i : int = 0;i < _content.numChildren;i++) {
				base = _content.getChildAt(i);
				GAlignLayout.layout(base);
			}
		}

		/**
		 * @private
		 */
		override protected function onHide() : void {
			if (_modalSkin != null) {
				_modalSkin.parent.removeChild(_modalSkin);
			}
		}

		override protected function onStageResize() : void {
			addRender(showModal);
		}
		
		protected function showModal():void{
			if (_modalSkin != null) {
				_modalSkin.width = GUIUtil.root.stage.stageWidth;
				_modalSkin.height = GUIUtil.root.stage.stageHeight;
				GUIUtil.root.stage.focus = null;
				_modalSkin.width = GUIUtil.root.stage.stageWidth;
				_modalSkin.height = GUIUtil.root.stage.stageHeight;
				parent.addChildAt(_modalSkin, parent.numChildren - 1);
				parent.setChildIndex(this, parent.numChildren - 1);
			}
		}

		public function GPanel() {
		}

		public function set bgSkin(value :IGSkin) : void {
			if (_bgSkin == value) {
				return;
			}
			if (_bgSkin != null) {
				_bgSkin.remove();
			}
			_bgSkin = value;
			if (_bgSkin == null) {
			}
			_bgSkin.addTo(this);
			if (_scaleMode == GScaleMode.FIT_SIZE) {
				forceSize(_bgSkin.width, _bgSkin.height);
			}
		}

		/**
		 * 设置模式
		 */
		public function set modal(value : Boolean) : void {
			if ((_modalSkin != null) == value) {
				return;
			}
			if (value) {
				//_modalSkin = GUIUtil.theme.modalSkin;
				addRender(showModal);
			} else {
				if (_modalSkin != null && _modalSkin.parent != null) {
					_modalSkin.parent.removeChild(_modalSkin);
				}
				_modalSkin = null;
			}
		}

		public function add(value : GBase) : void {
			if(value==null){
				return;
			}
			_content.addChild(value);
		}
	}
}
