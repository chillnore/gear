package gear.gui.controls {
	import gear.gui.core.GBase;
	import gear.ui.cell.LabelSource;
	import gear.ui.data.GLabelData;
	import gear.ui.layout.GLayout;
	import gear.ui.manager.UIManager;
	import gear.utils.BDUtil;
	import gear.utils.GStringUtil;

	import flash.display.BlendMode;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * 标签控件
	 * 
	 * @author bright
	 * @version 20120814
	 */
	public class GLabel extends GBase {
		/**
		 * @private
		 */
		protected var _data : GLabelData;
		/**
		 * @private
		 */
		protected var _icon : GIcon;
		/**
		 * @private
		 */
		protected var _textField : TextField;
		/**
		 * @private
		 */
		protected var _text : String;
		protected var _htmlText : String;

		/**
		 * @private
		 */
		override protected function create() : void {
			_icon = new GIcon(_data.iconData);
			addChild(_icon);
			if (_data.textField == null) {
				_textField = UIManager.getTextField();
				_textField.defaultTextFormat = _data.textFormat;
				_textField.styleSheet = _data.styleSheet;
				_textField.textColor = _data.color.upColor;
				_textField.filters = _data.textFieldFilters;
				_textField.autoSize = TextFieldAutoSize.LEFT;
			} else {
				_textField = _data.textField;
			}
			_textField.mouseEnabled = false;
			_textField.selectable = true;
			if (_data.text.length > 0) {
				text = _data.text;
			}
			if (_data.htmlText.length > 0) {
				htmlText = _data.htmlText;
			}
			if (_data.textFieldAlpha < 1) {
				blendMode = BlendMode.LAYER;
				_textField.alpha = _data.textFieldAlpha;
			}
			if (_data.width > 0) {
				_textField.width = _data.width;
				_textField.wordWrap = true;
			}
			addChild(_textField);
		}

		/**
		 * @private
		 */
		override protected function layout() : void {
			_icon.render();
			var iconW : int = _icon.width;
			var iconH : int = _icon.height;
			var textW : int = 0;
			var textH : int = 0;
			var rect : Rectangle;
			if (_textField.text.length > 0) {
				rect = BDUtil.getDOSize(_textField);
				textW = rect.x * 2 + rect.width;
				textH = rect.y * 2 + rect.height;
			}
			_width = iconW + _data.hGap + textW;
			_height = Math.max(iconH, textH);
			if (_data.iconY == 0) {
				_icon.y = (_height - iconH) >> 1;
			} else {
				_icon.y = _textField.y + rect.y + rect.height + _data.iconY - iconH;
			}
			_textField.x = (iconW == 0 ? 0 : iconW + _data.hGap);
			_textField.y = (_height - textH) >> 1;
			GLayout.layout(this);
		}

		protected function updateText() : void {
			_textField.text = _text;
			layout();
		}

		protected function updateHtmlText() : void {
			_textField.htmlText = _htmlText;
			layout();
		}

		/**
		 * 标签控件
		 */
		public function GLabel(data : GLabelData) {
			_data = data;
			super(data);
		}

		/**
		 * @return 位图控件
		 */
		public function get icon() : GIcon {
			return _icon;
		}

		/**
		 * 设置文本
		 * 
		 * @param value String 文本
		 */
		public function set text(value : String) : void {
			_text = GStringUtil.truncateToFit(value, _data.maxLength);
			addRender(updateText);
		}

		/**
		 * 获得文本
		 * 
		 * @return value 文本	
		 */
		public function get text() : String {
			return _text;
		}

		/**
		 * 直接更新比推迟更新快
		 * 
		 * @param value uint 设置文本颜色
		 */
		public function set textColor(value : uint) : void {
			_textField.textColor = value;
		}

		/**
		 * 设置HTML文本
		 * 
		 * @param value String HTML文本
		 */
		public function set htmlText(value : String) : void {
			_htmlText = value;
			addRender(updateHtmlText);
		}

		/**
		 * @return String HTML
		 */
		public function get htmlText() : String {
			return _htmlText;
		}

		/**
		 * clear 清除文本
		 */
		public function clear() : void {
			text = "";
			htmlText = "";
		}

		/**
		 * @inheritDoc
		 */
		override public function set source(value : *) : void {
			if (value == null) {
				clear();
				return;
			}
			if (value is LabelSource) {
				text = LabelSource(value).text;
			} else {
				text = String(value);
			}
			_source = value;
		}
	}
}
