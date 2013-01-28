package gear.game.move {
	/**
	 * 移动接口
	 * 
	 * @author bright
	 * @version 20121225
	 */
	public interface IGMove {
		function set mode(value : int) : void;

		function set speed(value : Number) : void;

		function setTo(start : int, dist : int) : void;

		function get total() : int;

		function set total(value : int) : void;

		function next() : void;

		function get current() : int;

		function set dist(value : int) : void;

		function get dist() : int;
	}
}
