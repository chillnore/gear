package gear.socket {

	/**
	 * @author BrightLi
	 * @version 20100315
	 */
	public interface ISyncObject {

		function toObject() : Object;

		function parse(value : Object) : void;
	}
}
