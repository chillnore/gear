package gear.ui.drag {
	/**
	 * 拖动目标接口
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public interface IDragTarget {
		/**
		 * 拖进
		 * 
		 * @param dragData 拖动数据
		 * @return 是否受理拖动
		 */
		function dragEnter(dragData : DragData) : Boolean;

		/**
		 * 能否交换拖动项
		 * 
		 * @param source 源项
		 * @param target 目标项
		 * @return 能否交换
		 */
		function canSwap(source : IDragItem, target : IDragItem):Boolean;
	}
}
