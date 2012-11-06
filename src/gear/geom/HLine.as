package gear.geom {
	import gear.utils.GMathUtil;

	import flash.geom.Point;


	/**
	 * 水平线-可用于出生线配置
	 * 
	 * @author bright
	 * @version 20101015
	 */
	public class HLine {
		private var _x : int;
		private var _y : int;
		private var _width : int;

		/**
		 * 构造函数
		 * 
		 * @param x 左侧起点X坐标
		 * @param y 左侧起点Y坐标
		 * @param width 线宽度 
		 */
		public function HLine(x : int, y : int, width : int) {
			_x = x;
			_y = y;
			_width = width;
		}

		/**
		 * 左侧起点X坐标
		 * 
		 * @return X坐标
		 */
		public function get x() : int {
			return _x;
		}

		/**
		 * 左侧起点Y坐标
		 * 
		 * @return 左侧Y坐
		 */
		public function get y() : int {
			return _y;
		}

		/**
		 * 水平线宽度
		 * 
		 * @return 水平线宽
		 */
		public function get width() : int {
			return _width;
		}

		/**
		 * 获得水平线上的随机点
		 * 
		 * @return 水平线上的随机点
		 */
		public function getRandomPoint() : Point {
			var x : int = _x + GMathUtil.random(0, _width);
			return new Point(x, _y);
		}

		/**
		 * 转换成字符串
		 * 
		 * @return 字符串	 	 * @example
		 * <listing version="3.0">
		 * var hline:HLine=new HLine(10,10,100);
		 * trace(hline.toString()) // 输出"x=10,y=10,width=100"
		 * </listing>
		 */
		public function toString() : String {
			return "x=" + _x + ",y=" + _y + ",width=" + _width;
		}
	}
}