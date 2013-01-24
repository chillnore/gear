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
		function get buttonSkin() : IGSkin;

		function get cellSkin() : IGSkin;

		function get checkBoxIcon() : IGSkin;

		function get emptySkin() : IGSkin;
		
		function get hScrollBarTrackSkin() : IGSkin;

		function get hScrollBarThumbSkin() : IGSkin;

		function get hScrollBarThumbIcon() : BitmapData;

		function get hScrollBarArrowUpSkin() : IGSkin;

		function get hScrollBarArrowDownSkin() : IGSkin;

		function get listSkin() : IGSkin;

		function get modalSkin() : IGSkin;

		function get panelBgSkin() : IGSkin;

		function get progressBarTrackSkin() : IGSkin;

		function get progressBarBarSkin() : IGSkin;

		function get radioButtonIcon() : IGSkin;

		function get vScrollBarTrackSkin() : IGSkin;

		function get vScrollBarThumbSkin() : IGSkin;

		function get vScrollBarThumbIcon() : BitmapData;

		function get vScrollBarArrowUpSkin() : IGSkin;

		function get vScrollBarArrowDownSkin() : IGSkin;

		function get textAreaBorderSkin() : IGSkin;

		function get textInputBorderSkin() : IGSkin;

		function get toggleButtonSkin() : IGSkin;

		function get leftArrowIcon() : BitmapData;

		function get rightArrowIcon() : BitmapData;
	}
}