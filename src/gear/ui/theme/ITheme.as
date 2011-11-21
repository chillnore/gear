package gear.ui.theme {
	import flash.display.Sprite;

	/**
	 * ITheme as3绘制主题接口
	 * 
	 * @author bright
	 * @version 20101008
	 */
	public interface ITheme {

		function get GButton_upSkin() : Sprite;

		function get GButton_overSkin() : Sprite;

		function get GButton_downSkin() : Sprite;

		function get GButton_disabledSkin() : Sprite;

		function get GButton_selectedUpSkin() : Sprite;

		function get GButton_selectedOverSkin() : Sprite;

		function get GButton_selectedDownSkin() : Sprite;

		function get GButton_selectedDisabledSkin() : Sprite;

		function get GProgressBar_trackSkin() : Sprite;

		function get GProgressBar_barSkin() : Sprite;

		function get GPanel_bgSkin() : Sprite;

		function get GScrollBar_trackSkin() : Sprite;

		function get GScrollBar_thumbUpSkin() : Sprite;

		function get GScrollBar_thumbOverSkin() : Sprite;

		function get GScrollBar_thumbDownSkin() : Sprite;

		function get GTextArea_bgSkin() : Sprite;
	}
}