package gear.gui.model {
	import gear.gui.cell.IGCell;

	import flash.display.BitmapData;

	/**
	 * @author Administrator
	 */
	public interface IGTreeCell extends IGCell {
		function set icon(value:BitmapData):void;
	}
}
