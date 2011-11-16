package gear.render {
	import flash.events.TimerEvent;

	/**
	 * @author Administrator
	 */
	public interface ITimerRender {
		function refresh(elapsed : int, event : TimerEvent) : void;
	}
}
