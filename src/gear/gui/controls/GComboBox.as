package gear.gui.controls {
	import gear.gui.core.GBase;
	import gear.gui.skin.GComboBoxSkin;

	/**
	 * 组合框控件
	 * 
	 * @author bright
	 * @version 20130419
	 */
	public class GComboBox extends GBase {
		protected var _arrow : GButton;
		protected var _textInput : GTextInput;
		protected var _editabled : GButton;
		protected var _list : GList;

		override protected function preinit() : void {
			setSize(100, 22);
		}

		override protected function create() : void {
			_arrow = new GButton();
			_arrow.skin = GComboBoxSkin.arrowSkin;
			addChild(_arrow);
			_textInput = new GTextInput();
			_textInput.borderSkin = null;
			addChild(_textInput);
			_editabled = new GButton();
			_editabled.skin = GComboBoxSkin.editableSkin;
			_editabled.setSize(21, 22);
			addChild(_editabled);
			_list = new GList();
		}

		override protected function resize() : void {
			_arrow.setSize(_width, _height);
			_editabled.x = _width - _editabled.width;
			_editabled.height = _height;
		}

		override protected function onEnabled() : void {
			_arrow.enabled = _enabled;
			_textInput.enabled = _enabled;
			_editabled.enabled = _enabled;
		}
	}
}
