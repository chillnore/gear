package gear.gui.skin.theme {
	import gear.gui.skin.IGSkin;

	import flash.display.BitmapData;

	/**
	 * 皮肤主题接口
	 * 
	 * @author bright
	 * @version 20130110
	 */
	public interface IGTheme {
		function get emptySkin() : IGSkin;

		function get buttonSkin() : IGSkin;

		function get checkBoxIcon() : IGSkin;

		function get panelBgSkin() : IGSkin;

		function get progressBarTrackSkin() : IGSkin;

		function get progressBarBarSkin() : IGSkin;

		function get radioButtonIcon() : IGSkin;

		function get scrollBarTrackSkin() : IGSkin;

		function get scrollBarThumbSkin() : IGSkin;

		function get scrollBarThumbIcon() : BitmapData;

		function get scrollBarArrowUpSkin() : IGSkin;

		function get scrollBarArrowDownSkin() : IGSkin;

		function get textAreaBorderSkin() : IGSkin;

		function get textInputBorderSkin() : IGSkin;

		function get toggleButtonSkin() : IGSkin;

		function get leftArrowIcon() : BitmapData;

		function get rightArrowIcon() : BitmapData;
	}
}