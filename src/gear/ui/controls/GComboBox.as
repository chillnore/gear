package gear.ui.controls {
	import gear.ui.cell.GCell;
	import gear.ui.core.GBase;
	import gear.ui.data.GComboBoxData;
	import gear.ui.manager.UIManager;
	import gear.ui.model.ListModel;
	import gear.ui.model.SelectionModel;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * 组合框控件
	 * 
	 * @author bright
	 * @version 20101015
	 * @example
	 * <listing version="3.0">
	 * var data : GComboBoxData = new GComboBoxData();
	 * var comboBox : GComboBox = new GComboBox(data);
	 * comboBox.model.source = [new LabelSource("item0"), new LabelSource("item1")];
	 * comboBox.selectionModel.index = 0;
	 * addChild(comboBox);
	 * </listing>
	 */
	public class GComboBox extends GBase {
		/**
		 * @private
		 */
		protected var _data : GComboBoxData;
		/**
		 * @private
		 */
		protected var _button : GButton;
		/**
		 * @private
		 */
		protected var _textInput : GTextInput;
		/**
		 * @private
		 */
		protected var _arrow : GButton;
		/**
		 * @private
		 */
		protected var _list : GList;
		/**
		 * @private
		 */
		protected var _editable : Boolean;

		/**
		 * @private
		 */
		override protected function create() : void {
			_button = new GButton(_data.buttonData);
			_textInput = new GTextInput(_data.textInputData);
			_arrow = new GButton(_data.arrow);
			_list = new GList(_data.listData);
			_editable = _data.editable;
			if (_editable) {
				addChild(_textInput);
				addChild(_arrow);
			} else {
				addChild(_button);
			}
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			_button.setSize(_width, _height);
			_textInput.width = _width - _arrow.width;
			_arrow.x = _width - _arrow.width;
		}

		/**
		 * @private
		 */
		protected function clickHandler(event : MouseEvent) : void {
			if (_list.parent) {
				_list.parent.removeChild(_list);
			} else {
				var global : Point = localToGlobal(new Point(0, _height));
				_list.moveTo(global.x, global.y);
				UIManager.root.addChild(_list);
			}
		}

		/**
		 * @private
		 */
		protected function list_singleClickHandler(event : Event) : void {
			if (_list.selectionModel.isSelected) {
				var value : Object = _list.selection;
				if (value != null) {
					if (_editable) {
						_textInput.text = value.toString();
					} else {
						_button.text = value.toString();
					}
				}
			}
			_list.hide();
		}

		/**
		 * @private
		 */
		override protected function onShow() : void {
			_button.addEventListener(MouseEvent.CLICK, clickHandler);
			_arrow.addEventListener(MouseEvent.CLICK, clickHandler);
			_list.addEventListener(GCell.SINGLE_CLICK, list_singleClickHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_mouseDownHandler);
		}

		/**
		 * @private
		 */
		override protected function onHide() : void {
			_button.removeEventListener(MouseEvent.CLICK, clickHandler);
			_arrow.removeEventListener(MouseEvent.CLICK, clickHandler);
			_list.removeEventListener(GCell.SINGLE_CLICK, list_singleClickHandler);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, stage_mouseDownHandler);
		}

		private function stage_mouseDownHandler(event : MouseEvent) : void {
			var target : DisplayObject = event.target as DisplayObject;
			if (UIManager.atParent(target, _list)) {
				return;
			}
			if (UIManager.atParent(target, this)) {
				return;
			}
			_list.hide();
		}

		private function selectHandler(event : Event) : void {
			if (_list.selectionModel.isSelected) {
				var value : Object = _list.selection;
				if (value) {
					if (_editable) {
						_textInput.text = value.toString();
					} else {
						_button.text = value.toString();
					}
				}
			}
			_list.hide();
		}

		/**
		 * @inheritDoc
		 */
		public function GComboBox(data : GComboBoxData) {
			_data = data;
			super(_data);
			_list.selectionModel.addEventListener(Event.CHANGE, selectHandler);
		}

		/**
		 * @return 列表模型
		 */
		public function get model() : ListModel {
			return _list.model;
		}

		/**
		 * @return 选择模型
		 */
		public function get selectionModel() : SelectionModel {
			return _list.selectionModel;
		}

		/**
		 * @return 列表控件
		 */
		public function get list() : GList {
			return _list;
		}
	}
}
