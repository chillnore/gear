package gear.codec.gpk.tag {
	/**
	 * @author bright
	 */
	public class GpkTagFactory {
		public static function create(type:String):AGpkTag{
			switch(type){
				case GpkTagAMF.TYPE:
					return new GpkTagAMF();
				case GpkTagLBD.TYPE:
					return new GpkTagLBD();
				case GpkTagSBD.TYPE:
					return new GpkTagSBD();
			}
			return null;
		}
	}
}
