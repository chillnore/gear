package gear.codec.swf.tags {
	/**
	 * @author bright
	 */
	public class GTagFactory {
		public static function create(type : int) : IGSwfTag {
			switch(type) {
				case GTagEnd.TYPE:
					return new GTagEnd();
				case GTagShowFrame.TYPE:
					return new GTagShowFrame();
				case GTagDefineShape.TYPE:
					return new GTagDefineShape();
				case GTagSetBackgroundColor.TYPE:
					return new GTagSetBackgroundColor();
				case GTagPlaceObject2.TYPE:
					return new GTagPlaceObject2();
				case GTagDefineBitsJPEG3.TYPE:
					return new GTagDefineBitsJPEG3();
				case GTagFileAttributes.TYPE:
					return new GTagFileAttributes();
				case GTagMetaData.TYPE:
					return new GTagMetaData();
				case GTagDefineSceneAndFrameLabelData.TYPE:
					return new GTagDefineSceneAndFrameLabelData();
			}
			return null;
		}
	}
}
