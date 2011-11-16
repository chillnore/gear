package gear.ui.color {
	/**
	 * HSB
	 * 
	 * @author bright
	 * @version 20101008
	 */
	public class HSB {
		public var hue : Number;
		public var saturation : Number;
		public var brightness : Number;

		public function HSB(h : Number = NaN, s : Number = NaN, b : Number = NaN) {
			hue = h;
			saturation = s;
			brightness = b;
		}

		/**
		 * Converts an HSB color specified by the parameters to a uint RGB color.
		 * hue 色相
		 * saturation 饱和度
		 * brightness 亮度
		 */
		public static function convertHSBtoRGB(hue : Number, saturation : Number, brightness : Number) : uint {
			var r : Number, g : Number, b : Number;
			if (saturation == 0) {
				r = g = b = brightness;
			} else {
				var h : Number = (hue % 360) / 60;
				var i : int = int(h);
				var f : Number = h - i;
				var p : Number = brightness * (1 - saturation);
				var q : Number = brightness * (1 - (saturation * f));
				var t : Number = brightness * (1 - (saturation * (1 - f)));
				switch (i) {
					case 0:
						r = brightness;
						g = t;
						b = p;
						break;
					case 1:
						r = q;
						g = brightness;
						b = p;
						break;
					case 2:
						r = p;
						g = brightness;
						b = t;
						break;
					case 3:
						r = p;
						g = q;
						b = brightness;
						break;
					case 4:
						r = t;
						g = p;
						b = brightness;
						break;
					case 5:
						r = brightness;
						g = p;
						b = q;
						break;
				}
			}
			r *= 255;
			g *= 255;
			b *= 255;
			return (r << 16 | g << 8 | b);
		}

		public static function convertRGBtoHSB(rgb : uint) : HSB {
			var hue : Number, saturation : Number, brightness : Number;
			var r : Number = ((rgb >> 16) & 0xff) / 255;
			var g : Number = ((rgb >> 8) & 0xff) / 255;
			var b : Number = (rgb & 0xff) / 255;
			var max : Number = Math.max(r, Math.max(g, b));
			var min : Number = Math.min(r, Math.min(g, b));
			var delta : Number = max - min;
			brightness = max;
			if (max != 0)
				saturation = delta / max;
			else
				saturation = 0;
			if (saturation == 0)
				hue = NaN;
			else {
				if (r == max)
					hue = (g - b) / delta;
				else if (g == max)
					hue = 2 + (b - r) / delta;
				else if (b == max)
					hue = 4 + (r - g) / delta;
				hue = hue * 60;
				if (hue < 0)
					hue += 360;
			}
			return new HSB(hue, saturation, brightness);
		}
	}
}