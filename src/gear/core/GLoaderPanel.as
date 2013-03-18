package gear.core {
	import gear.gui.core.GAlign;
	import gear.gui.controls.GProgressBar;
	import gear.gui.containers.GPanel;

	/**
	 * @author bright
	 * @version 20130309xz
	 */
	public class GLoaderPanel extends GPanel {
		protected var _progressBar : GProgressBar;

		protected function initView() : void {
			setSize(300, 80);
			align = GAlign.CENTER;
			_bgSkin=null;
			_progressBar = new GProgressBar();
			_progressBar.align = new GAlign(10, 10, -1, -1, -1, 0);
			add(_progressBar);
		}

		public function GLoaderPanel() {
			initView();
		}
		
		public function get progressBar():GProgressBar{
			return _progressBar;
		}
	}
}
