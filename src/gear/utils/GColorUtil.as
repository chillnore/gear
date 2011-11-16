package gear.utils {
	import gear.ui.color.ARGB;

	import flash.display.BitmapData;
	import flash.geom.ColorTransform;

	/**
	 * Game Color Util
	 * 
	 * @author bright
	 * @version 20101008
	 */
	public class GColorUtil {
		/**
		 * @param rgb uint Original RGB color.
		 * @param brite Number -255 to 255.
		 * @return New RGB color.
		 */
		public static function adjustBrightness(rgb : uint, brite : Number) : uint {
			brite = Math.max(-255, Math.min(255, brite));
			var r : Number = Math.max(Math.min(((rgb >> 16) & 0xFF) + brite, 255), 0);
			var g : Number = Math.max(Math.min(((rgb >> 8) & 0xFF) + brite, 255), 0);
			var b : Number = Math.max(Math.min((rgb & 0xFF) + brite, 255), 0);
			return (r << 16) | (g << 8) | b;
		}

		/**
		 * @param rgb uint Original RGB color.
		 * @param brite Number -100 to 100.
		 * @return New RGB color.
		 */
		public static function adjustBrightness2(rgb : uint, brite : Number) : uint {
			brite = Math.max(-100, Math.min(100, brite));
			var r : Number;
			var g : Number;
			var b : Number;
			if (brite == 0) {
				return rgb;
			}
			if (brite < 0) {
				brite = (100 + brite) / 100;
				r = ((rgb >> 16) & 0xFF) * brite;
				g = ((rgb >> 8) & 0xFF) * brite;
				b = (rgb & 0xFF) * brite;
			} else {
				brite /= 100;
				r = ((rgb >> 16) & 0xFF);
				g = ((rgb >> 8) & 0xFF);
				b = (rgb & 0xFF);
				r += ((0xFF - r) * brite);
				g += ((0xFF - g) * brite);
				b += ((0xFF - b) * brite);
				r = Math.min(r, 255);
				g = Math.min(g, 255);
				b = Math.min(b, 255);
			}
			return (r << 16) | (g << 8) | b;
		}

		public static function rgbMultiply(rgb1 : uint, rgb2 : uint) : uint {
			var r1 : Number = (rgb1 >> 16) & 0xFF;
			var g1 : Number = (rgb1 >> 8) & 0xFF;
			var b1 : Number = rgb1 & 0xFF;
			var r2 : Number = (rgb2 >> 16) & 0xFF;
			var g2 : Number = (rgb2 >> 8) & 0xFF;
			var b2 : Number = rgb2 & 0xFF;
			return ((r1 * r2 / 255) << 16) | ((g1 * g2 / 255) << 8) | (b1 * b2 / 255);
		}

		public static function changeBDColor(bd : BitmapData, color : uint) : void {
			bd.colorTransform(bd.rect, getColorTransform(color));
		}

		public static function getColorTransform(color : uint) : ColorTransform {
			var argb : ARGB = new ARGB();
			argb.parse(color);
			var rm : Number = argb.red / 255;
			var gm : Number = argb.green / 255;
			var bm : Number = argb.blue / 255;
			return new ColorTransform(rm, gm, bm, 1, 0, 0, 0, 0);
		}

		public static function interpolateColors(color1 : uint, color2 : uint, ratio : Number) : uint {
			var inv : Number = 1 - ratio;
			var red : uint = Math.round(( ( color1 >>> 16 ) & 255 ) * ratio + ( ( color2 >>> 16 ) & 255 ) * inv);
			var green : uint = Math.round(( ( color1 >>> 8 ) & 255 ) * ratio + ( ( color2 >>> 8 ) & 255 ) * inv);
			var blue : uint = Math.round(( ( color1 ) & 255 ) * ratio + ( ( color2 ) & 255 ) * inv);
			var alpha : uint = Math.round(( ( color1 >>> 24 ) & 255 ) * ratio + ( ( color2 >>> 24 ) & 255 ) * inv);
			return ( alpha << 24 ) | ( red << 16 ) | ( green << 8 ) | blue;
		}
	}
}