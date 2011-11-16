package gear.motion {
	/**
	 * @author admin
	 */
	public interface IGTween {
		function set target(value : Object) : void;

		function init(target : Object, duration : int, ease : Function) : void;

		function next() : Boolean;

		function get position() : Number;

		function reset() : void;
	}
}
