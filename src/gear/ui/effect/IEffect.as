package gear.ui.effect {
	import flash.display.DisplayObject;

	/**
	 * @author flashpf
	 */
	public interface IEffect {
		function set target(value : DisplayObject) : void;

		function start() : void;
	}
}
