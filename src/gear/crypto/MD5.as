package gear.crypto {
	import gear.utils.IntUtil;

	import flash.utils.ByteArray;


	/**
	 * MD5加密算法
	 * 
	 * @author bright
	 * @version 20101015
	 * @example
	 * <listing version="3.0">
	 * var pwd_md5:String=MD5.hash("password");
	 * </listing>
	 */
	public final class MD5 {
		/**
		 * @private
		 */
		private static var _digest : ByteArray;

		/**
		 * @private
		 */
		private static function f(x : int, y : int, z : int) : int {
			return ( x & y ) | ( (~x) & z );
		}

		/**
		 * @private
		 */
		private static function g(x : int, y : int, z : int) : int {
			return ( x & z ) | ( y & (~z) );
		}

		/**
		 * @private
		 */
		private static function h(x : int, y : int, z : int) : int {
			return x ^ y ^ z;
		}

		/**
		 * @private
		 */
		private static function i(x : int, y : int, z : int) : int {
			return y ^ ( x | (~z) );
		}

		/**
		 * @private
		 */
		private static function transform(func : Function, a : int, b : int, c : int, d : int, x : int, s : int, t : int) : int {
			var tmp : int = a + int(func(b, c, d)) + x + t;
			return IntUtil.rol(tmp, s) + b;
		}

		/**
		 * @private
		 */
		private static function ff(a : int, b : int, c : int, d : int, x : int, s : int, t : int) : int {
			return transform(f, a, b, c, d, x, s, t);
		}

		/**
		 * @private
		 */
		private static function gg(a : int, b : int, c : int, d : int, x : int, s : int, t : int) : int {
			return transform(g, a, b, c, d, x, s, t);
		}

		/**
		 * @private
		 */
		private static function hh(a : int, b : int, c : int, d : int, x : int, s : int, t : int) : int {
			return transform(h, a, b, c, d, x, s, t);
		}

		/**
		 * @private
		 */
		private static function ii(a : int, b : int, c : int, d : int, x : int, s : int, t : int) : int {
			return transform(i, a, b, c, d, x, s, t);
		}

		/**
		 * @private
		 */
		private static function createBlocks(s : ByteArray) : Array {
			var blocks : Array = new Array();
			var len : int = s.length * 8;
			var mask : int = 0xFF;
			for( var i : int = 0;i < len; i += 8 ) {
				blocks[ int(i >> 5) ] |= ( s[ i / 8 ] & mask ) << ( i % 32 );
			}
			blocks[ int(len >> 5) ] |= 0x80 << ( len % 32 );
			blocks[ int(( ( ( len + 64 ) >>> 9 ) << 4 ) + 14) ] = len;
			return blocks;
		}

		/**
		 * 生成字符串的MD5码
		 * 
		 * @param value 要加密的字符串
		 * @return String 字符串
		 */
		public static function hash(value : String) : String {
			var ba : ByteArray = new ByteArray();
			ba.writeUTFBytes(value);
			return hashBinary(ba);
		}

		/**
		 * 计算字符数组的MD5编码
		 * 
		 * @param value 字符数组
		 * @return MD码	 */
		public static function hashBinary(value : ByteArray) : String {
			var a : int = 1732584193;
			var b : int = -271733879;
			var c : int = -1732584194;
			var d : int = 271733878;
			var aa : int;
			var bb : int;
			var cc : int;
			var dd : int;
			var x : Array = createBlocks(value);
			var len : int = x.length;
			for ( var i : int = 0;i < len; i += 16) {
				aa = a;
				bb = b;
				cc = c;
				dd = d;
				// Round 1

				a = ff(a, b, c, d, x[int(i + 0)], 7, -680876936);
				// 1

				d = ff(d, a, b, c, x[int(i + 1)], 12, -389564586);
				// 2

				c = ff(c, d, a, b, x[int(i + 2)], 17, 606105819);
				// 3

				b = ff(b, c, d, a, x[int(i + 3)], 22, -1044525330);
				// 4

				a = ff(a, b, c, d, x[int(i + 4)], 7, -176418897);
				// 5

				d = ff(d, a, b, c, x[int(i + 5)], 12, 1200080426);
				// 6

				c = ff(c, d, a, b, x[int(i + 6)], 17, -1473231341);
				// 7

				b = ff(b, c, d, a, x[int(i + 7)], 22, -45705983);
				// 8

				a = ff(a, b, c, d, x[int(i + 8)], 7, 1770035416);
				// 9

				d = ff(d, a, b, c, x[int(i + 9)], 12, -1958414417);
				// 10

				c = ff(c, d, a, b, x[int(i + 10)], 17, -42063);
				// 11

				b = ff(b, c, d, a, x[int(i + 11)], 22, -1990404162);
				// 12

				a = ff(a, b, c, d, x[int(i + 12)], 7, 1804603682);
				// 13

				d = ff(d, a, b, c, x[int(i + 13)], 12, -40341101);
				// 14

				c = ff(c, d, a, b, x[int(i + 14)], 17, -1502002290);
				// 15

				b = ff(b, c, d, a, x[int(i + 15)], 22, 1236535329);
				// 16

				// Round 2

				a = gg(a, b, c, d, x[int(i + 1)], 5, -165796510);
				// 17

				d = gg(d, a, b, c, x[int(i + 6)], 9, -1069501632);
				// 18

				c = gg(c, d, a, b, x[int(i + 11)], 14, 643717713);
				// 19

				b = gg(b, c, d, a, x[int(i + 0)], 20, -373897302);
				// 20

				a = gg(a, b, c, d, x[int(i + 5)], 5, -701558691);
				// 21

				d = gg(d, a, b, c, x[int(i + 10)], 9, 38016083);
				// 22

				c = gg(c, d, a, b, x[int(i + 15)], 14, -660478335);
				// 23

				b = gg(b, c, d, a, x[int(i + 4)], 20, -405537848);
				// 24

				a = gg(a, b, c, d, x[int(i + 9)], 5, 568446438);
				// 25

				d = gg(d, a, b, c, x[int(i + 14)], 9, -1019803690);
				// 26

				c = gg(c, d, a, b, x[int(i + 3)], 14, -187363961);
				// 27

				b = gg(b, c, d, a, x[int(i + 8)], 20, 1163531501);
				// 28

				a = gg(a, b, c, d, x[int(i + 13)], 5, -1444681467);
				// 29

				d = gg(d, a, b, c, x[int(i + 2)], 9, -51403784);
				// 30

				c = gg(c, d, a, b, x[int(i + 7)], 14, 1735328473);
				// 31

				b = gg(b, c, d, a, x[int(i + 12)], 20, -1926607734);
				// 32

				// Round 3

				a = hh(a, b, c, d, x[int(i + 5)], 4, -378558);
				// 33

				d = hh(d, a, b, c, x[int(i + 8)], 11, -2022574463);
				// 34

				c = hh(c, d, a, b, x[int(i + 11)], 16, 1839030562);
				// 35

				b = hh(b, c, d, a, x[int(i + 14)], 23, -35309556);
				// 36

				a = hh(a, b, c, d, x[int(i + 1)], 4, -1530992060);
				// 37

				d = hh(d, a, b, c, x[int(i + 4)], 11, 1272893353);
				// 38

				c = hh(c, d, a, b, x[int(i + 7)], 16, -155497632);
				// 39

				b = hh(b, c, d, a, x[int(i + 10)], 23, -1094730640);
				// 40

				a = hh(a, b, c, d, x[int(i + 13)], 4, 681279174);
				// 41

				d = hh(d, a, b, c, x[int(i + 0)], 11, -358537222);
				// 42

				c = hh(c, d, a, b, x[int(i + 3)], 16, -722521979);
				// 43

				b = hh(b, c, d, a, x[int(i + 6)], 23, 76029189);
				// 44

				a = hh(a, b, c, d, x[int(i + 9)], 4, -640364487);
				// 45

				d = hh(d, a, b, c, x[int(i + 12)], 11, -421815835);
				// 46

				c = hh(c, d, a, b, x[int(i + 15)], 16, 530742520);
				// 47

				b = hh(b, c, d, a, x[int(i + 2)], 23, -995338651);
				// 48

				// Round 4

				a = ii(a, b, c, d, x[int(i + 0)], 6, -198630844);
				// 49

				d = ii(d, a, b, c, x[int(i + 7)], 10, 1126891415);
				// 50

				c = ii(c, d, a, b, x[int(i + 14)], 15, -1416354905);
				// 51

				b = ii(b, c, d, a, x[int(i + 5)], 21, -57434055);
				// 52

				a = ii(a, b, c, d, x[int(i + 12)], 6, 1700485571);
				// 53

				d = ii(d, a, b, c, x[int(i + 3)], 10, -1894986606);
				// 54

				c = ii(c, d, a, b, x[int(i + 10)], 15, -1051523);
				// 55

				b = ii(b, c, d, a, x[int(i + 1)], 21, -2054922799);
				// 56

				a = ii(a, b, c, d, x[int(i + 8)], 6, 1873313359);
				// 57

				d = ii(d, a, b, c, x[int(i + 15)], 10, -30611744);
				// 58

				c = ii(c, d, a, b, x[int(i + 6)], 15, -1560198380);
				// 59

				b = ii(b, c, d, a, x[int(i + 13)], 21, 1309151649);
				// 60

				a = ii(a, b, c, d, x[int(i + 4)], 6, -145523070);
				// 61

				d = ii(d, a, b, c, x[int(i + 11)], 10, -1120210379);
				// 62

				c = ii(c, d, a, b, x[int(i + 2)], 15, 718787259);
				// 63

				b = ii(b, c, d, a, x[int(i + 9)], 21, -343485551);
				// 64

				a += aa;
				b += bb;
				c += cc;
				d += dd;
			}
			_digest = new ByteArray();
			_digest.writeInt(a);
			_digest.writeInt(b);
			_digest.writeInt(c);
			_digest.writeInt(d);
			_digest.position = 0;
			return IntUtil.toHex(a) + IntUtil.toHex(b) + IntUtil.toHex(c) + IntUtil.toHex(d);
		}
	}
}
