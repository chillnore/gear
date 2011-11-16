package gear.ui.controls {
	import gear.ui.core.GBase;
	import gear.ui.core.GBaseData;
	import gear.ui.layout.GLayout;
	import gear.ui.model.ListModel;
	import gear.ui.model.SelectionModel;
	import gear.utils.BDUtil;
	import gear.utils.GDrawUtil;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;


	/**
	 * 海报控件
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class GPoster extends GBase {
		/**
		 * @private
		 */
		protected var _bitmap : Bitmap;
		/**
		 * @private
		 */
		protected var _border : Sprite;
		/**
		 * @private
		 */
		protected var _selectionModel : SelectionModel;
		/**
		 * @private
		 */
		protected var _model : ListModel;

		/**
		 * @private
		 */
		override protected function create() : void {
			_bitmap = new Bitmap();
			addChild(_bitmap);
			_border = new Sprite();
			_border.mouseEnabled = _border.mouseEnabled = false;
			addChild(_border);
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			redrawBorder(_width, _height);
		}

		private function redrawBorder(w : int, h : int) : void {
			var g : Graphics = _border.graphics;
			g.clear();
			GDrawUtil.drawFillBorder(g, 0x000000, 1, 0, 0, w, h);
		}

		private function selection_changeHandler(event : Event) : void {
			var bd : BitmapData = _model.getAt(_selectionModel.index) as BitmapData;
			if (bd == null) {
				return;
			}
			_bitmap.bitmapData = BDUtil.getResizeBD(bd, _width, _height);
			_bitmap.smoothing = true;
		}

		/**
		 * @private
		 */
		override protected function onShow() : void {
			GLayout.layout(this);
		}

		/**
		 * @inheritDoc
		 */
		public function GPoster(base : GBaseData) {
			super(base);
			_selectionModel = new SelectionModel();
			_selectionModel.addEventListener(Event.CHANGE, selection_changeHandler);
			_model = new ListModel();
		}

		/**
		 * @return 选择模型
		 */
		public function get selectionModel() : SelectionModel {
			return _selectionModel;
		}

		/**
		 * @return 列表模型
		 */
		public function get model() : ListModel {
			return _model;
		}
	}
}