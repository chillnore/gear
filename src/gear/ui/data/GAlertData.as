package gear.ui.data {
	import gear.ui.core.GAlign;
	import gear.ui.core.GScaleMode;
	import gear.ui.manager.GUIUtil;

	/**
	 * 对话框控件定义
	 * 
	 * @author bright
	 * @version 20101027
	 */
	public class GAlertData extends GPanelData {
		/**
		 * 标签控件定义
		 */
		public var labelData : GLabelData;
		/**
		 * 输入框控件定义
		 */
		public var textInputData : GTextInputData;
		/**
		 * 按钮定义
		 */
		public var buttonData : GButtonData;
		/**
		 * 显示那一个或多个按钮
		 * @example
		 * var data:GAlertData=new GAlertData();
		 * data.flag=GAlert.OK|GAlert.CANCEL;
		 */
		public var flag : uint;
		/**
		 * 确定标签
		 */
		public var okLabel : String ;
		/**
		 * 取消标签
		 */
		public var cancelLabel : String;
		/**
		 * 是标签
		 */
		public var yesLabel : String ;
		/**
		 * 否标签
		 */
		public var noLabel : String ;
		/**
		 * 水平间距
		 */
		public var hgap : int ;
		/**
		 * 垂直间距
		 */
		public var vgap : int;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : GAlertData = source as GAlertData;
			if (data == null) {
				return;
			}
			data.labelData = labelData.clone();
			data.textInputData = (textInputData ? textInputData.clone() : null);
			data.buttonData = buttonData.clone();
			data.flag = flag;
			data.okLabel = okLabel;
			data.cancelLabel = cancelLabel;
			data.yesLabel = yesLabel;
			data.noLabel = noLabel;
			data.hgap = hgap;
			data.vgap = vgap;
		}

		public function GAlertData() {
			bgSkin = GUIUtil.getSkin("GPanel_bgSkin", "ui");
			labelData = new GLabelData();
			buttonData = new GButtonData();
			buttonData.width = 65;
			flag = 0x4;
			okLabel = "<b>确定</b>";
			cancelLabel = "<b>取消</b>";
			yesLabel = "<b>是</b>";
			noLabel = "<b>否</b>";
			hgap = vgap = 10;
			modal = true;
			scaleMode = GScaleMode.AUTO_SIZE;
			align = GAlign.CENTER;
			padding = 10;
			minWidth = 150;
			minHeight = 60;
		}

		/**
		 * @inheritDoc
		 */
		override public function clone() : * {
			var data : GAlertData = new GAlertData();
			parse(data);
			return data;
		}
	}
}
