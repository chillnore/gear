package gear.gui.controls {
	import gear.gui.utils.GUIUtil;
	import gear.gui.cell.IGCell;
	import gear.gui.core.GBase;
	import gear.gui.model.GListModel;
	import gear.gui.skins.GComboBoxSkin;

	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * 组合框控件
	 * 
	 * @author bright
	 * @version 20130419
	 */
	public class GComboBox extends GBase {
		protected var _arrow : GButton;
		protected var _textInput : GTextInput;
		protected var _dropDown : GButton;
		protected var _list : GList;
		protected var _editable : Boolean;
		protected var _prompt : String;

		override protected function preinit() : void {
			_editable = false;
			setSize(100, 22);
		}

		override protected function create() : void {
			_arrow = new GButton();
			_arrow.skin = GComboBoxSkin.arrowSkin;
			addChild(_arrow);
			_textInput = new GTextInput();
			_textInput.x = 2;
			_textInput.borderSkin = null;
			addChild(_textInput);
			_dropDown = new GButton();
			_dropDown.skin = GComboBoxSkin.editableSkin;
			_dropDown.setSize(21, 22);
			addChild(_dropDown);
			_list = new GList();
			_dropDown.onClick = onDropDown;
			_list.onCellClick = onCellClick;
		}

		override protected function resize() : void {
			_arrow.setSize(_width, _height);
			_dropDown.x = _width - _dropDown.width;
			_dropDown.height = _height;
		}

		override protected function onEnabled() : void {
			_arrow.enabled = _enabled;
			_textInput.enabled = _enabled;
			_dropDown.enabled = _enabled;
		}

		protected function onDropDown() : void {
			if (_list.parent == null) {
				var global : Point = localToGlobal(new Point(0, _height));
				_list.moveTo(global.x, global.y);
				stage.addChild(_list);
				stage.addEventListener(MouseEvent.CLICK, stageClickHandler);
			} else {
				stage.removeEventListener(MouseEvent.CLICK, stageClickHandler);
				_list.hide();
			}
		}

		protected function onCellClick(cell : IGCell) : void {
			_textInput.text = cell.source;
			_list.hide();
		}

		protected function stageClickHandler(event : MouseEvent) : void {
			var target : DisplayObject = DisplayObject(event.target);
			if (GUIUtil.atParent(target, _list) || GUIUtil.atParent(target, this)) {
				return;
			}
			_list.hide();
		}

		public function GComboBox() {
		}

		public function get model() : GListModel {
			return _list.model;
		}
	}
}
