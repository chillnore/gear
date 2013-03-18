package gear.core {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;

	/**
	 * SWF自加载
	 *        
	 * 用法：在需要实现自加载的类声明前加上<code>[Frame(factoryClass="gear.core.GPreloader")]</code>    
	 * 
	 * @author bright
	 * @version 20130309
	 */
	public class GPreloader extends MovieClip {
		protected var _loaderPanel : GLoaderPanel;

		protected function addedToStageHandler(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			if (loaderInfo.bytesLoaded < loaderInfo.bytesTotal) {
				loaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
				loaderInfo.addEventListener(Event.COMPLETE, completeHandler);
				_loaderPanel = new GLoaderPanel();
				parent.addChild(_loaderPanel);
			} else {
				startup();
			}
		}

		protected function progressHandler(event : ProgressEvent) : void {
			_loaderPanel.progressBar.model.setTo(loaderInfo.bytesLoaded,0, loaderInfo.bytesTotal);
		}

		protected function completeHandler(event : Event) : void {
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			loaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			_loaderPanel.hide();
			startup();
		}

		protected function startup() : void {
			var prefix : Array = currentLabels[1].name.split("_");
			var suffix : String = prefix.pop();
			var className : String = prefix.join(".") + "::" + suffix;
			gotoAndStop(2);
			if (loaderInfo.applicationDomain.hasDefinition(className)) {
				var mainClass : Class = loaderInfo.applicationDomain.getDefinition(className) as Class;
				var main : DisplayObject = new mainClass();
				parent.addChild(main);
				parent.removeChild(this);
			}
		}

		public function GPreloader() {
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
	}
}
