package gear.utils {
	import gear.log4a.GLogger;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.net.LocalConnection;
	import flash.sampler.getInvocationCount;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.system.fscommand;

	/**
	 * 系统工具类
	 * 
	 * @author bright
	 * @version 20130314
	 */
	public final class GSystemUtil {
		private static var _version : Number;

		public static function get version() : Number {
			if (isNaN(_version)) {
				var params : Array = Capabilities.version.split(" ")[1].split(",");
				_version = parseInt(params[0]) + parseInt(params[1]) / 10;
			}
			return _version;
		}

		public static function getInfo() : String {
			var result : String = "系统信息:\n";
			result += "浏览器类型:" + GJSUtil.browserAgent + "\n";
			result += "播放器当前版本:" + Capabilities.version + " ";
			result += "Debug:" + Capabilities.isDebugger + "\n";
			result += "分辨率:" + Capabilities.screenResolutionX + "×" + Capabilities.screenResolutionY + "\n";
			result += "播放器的类型:" + Capabilities.playerType + "\n";
			result += "当前的操作系统:" + Capabilities.os + "\n";
			result += "摄像头和麦克风是否禁止:" + Capabilities.avHardwareDisable;
			return result;
		}

		public static function xmlEncode(value : String) : String {
			var result : String = value;
			result = result.replace(/\x38/g, "&amp;");
			result = result.replace(/\x60/g, "&lt;");
			result = result.replace(/\x62/g, "&gt;");
			result = result.replace(/\x27/g, "&apos;");
			result = result.replace(/\x22/g, "&quot;");
			return result;
		}

		public static function gc() : void {
			try {
				new LocalConnection().connect("gc");
				new LocalConnection().connect("gc");
				System.gc();
			} catch (e : Error) {
			}
		}

		public static function getNowTime() : String {
			var date : Date = new Date();
			var result : String = date.getFullYear() + "-";
			result += (date.getMonth() + 1) + "-";
			result += date.getDate() + " ";
			result += date.getHours() + ":";
			result += date.getMinutes() + ":";
			result += date.getSeconds();
			return result;
		}

		public static function exit() : void {
			if (Capabilities.playerType == "StandAlone") {
				fscommand("quit");
			} else {
				GJSUtil.reload();
			}
		}

		public static function calcAll(target : DisplayObjectContainer, max : int = 1000000) : int {
			if (target == null) {
				return 0;
			}
			var list : Array = [target];
			var i : int;
			var j : int;
			var k : int;
			var l : int;
			var total : int = 0;
			var child : DisplayObject;
			var mc : MovieClip;
			while (list.length > 0 && total < max) {
				for (i = 0; i < list.length; i++) {
					target = list.shift() as DisplayObjectContainer;
					if (target == null) {
						continue;
					}
					mc = target as MovieClip;
					if (mc != null) {
						for (j = 0; j < mc.totalFrames; j++) {
							mc.gotoAndStop(j);
							l = mc.numChildren;
							for (k = 0; k < l; k++) {
								child = target.getChildAt(k);
								total++;
								if (child == null) {
									continue;
								}
								GLogger.debug(child.name, child);
								list.push(child);
							}
						}
					} else {
						l = target.numChildren;
						for (j = 0; j < l; j++) {
							child = target.getChildAt(j);
							total++;
							if (child == null) {
								continue;
							}
							GLogger.debug(child.name, child);
							list.push(child);
						}
					}
				}
			}
			return total;
		}

		public static function sample() : void {
			// trace执行次数
			getInvocationCount(undefined, new QName("", "trace"));
		}
	}
}