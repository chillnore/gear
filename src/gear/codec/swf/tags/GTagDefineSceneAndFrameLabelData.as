package gear.codec.swf.tags {
	import gear.codec.swf.GSwfStream;

	/**
	 * @author bright
	 */
	public class GTagDefineSceneAndFrameLabelData implements IGSwfTag {
		public static const TYPE : int = 86;
		public var sceneCount : int;
		public var sceneInfo : Vector.<Object>;
		public var frameLabelCount : int;
		public var frameInfo : Vector.<Object>;

		public function GTagDefineSceneAndFrameLabelData() {
		}

		public function decode(data : GSwfStream,length:uint) : void {
			sceneCount = data.readEncodedU32();
			sceneInfo = new Vector.<Object>();
			for (var i : int = 0;i < sceneCount;i++) {
				sceneInfo[i] = {offset:data.readEncodedU32(), name:data.readString()};
			}
			frameLabelCount = data.readEncodedU32();
			frameInfo = new Vector.<Object>();
			for (i = 0;i < frameLabelCount;i++) {
				frameInfo[i] = {number:data.readEncodedU32(), label:data.readString()};
			}
		}
	}
}
