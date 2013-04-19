package gear.gui.cell {
	import gear.gui.core.IGBase;

	/**
	 * 单元格接口
	 * 
	 * @author bright
	 * @version 20130314
	 */
	public interface IGCell extends IGBase {
		function set selected(value : Boolean) : void;

		function get selected() : Boolean;
	}
}
