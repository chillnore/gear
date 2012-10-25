package gear.key {
	/**
	 * 热键控制接口
	 * 
	 * @author bright
	 * @version 20121014
	 */
	public interface IKeyControl {
		function convertKeyCode(keyCode : uint) : uint;

		function keyDownFliter(keyCode : uint) : Boolean;
	}
}
