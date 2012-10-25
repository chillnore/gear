package gear.data
{
	/**
	 * @author cafe
	 */
	public class GUID
	{
		public var zoneId:int;
		public var time:uint;
		public var mapId:uint;
		public var index:uint;

		/**
		 * 相等
		 */
		public function equal( guid:GUID ):Boolean
		{
			return zoneId == guid.zoneId && time == guid.time && mapId == guid.mapId && index == guid.index;
		}

		public function toString():String
		{
			return zoneId + "," + time + "," + mapId + "," + index;
		}
	}
}
