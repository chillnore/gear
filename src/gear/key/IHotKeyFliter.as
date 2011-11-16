package gear.key {
	/**
	 * 热键控制过滤接口
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public interface IHotKeyFliter {
		function convertKeyCode(keyCode : uint) : uint;

		function keyDownFliter(keyCode : uint) : Boolean;
	}
}
