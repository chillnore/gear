package gear.gui.controls {
	import gear.gui.model.GChangeList;
	import gear.gui.core.GBase;
	import gear.gui.model.GChange;
	/**
	 * @author bright
	 */
	public class GGrid extends GBase{
		
		protected var _changes:GChangeList;
		
		protected function updateChanges() : void {
			var change:GChange;
			while(_changes.hasNext){
				change=_changes.shift();
				if(change.state==GChange.RESET){
				}else if(change.state==GChange.UPDATE){
				}
			}
		}
		
		public function GGrid(){
		}
	}
}
