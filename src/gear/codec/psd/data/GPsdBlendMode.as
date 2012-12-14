package gear.codec.psd.data {
	import flash.display.BlendMode;

	/**
	 * psd blend mode key:
	 *'norm' = normal 'dark' = darken 'lite' = lighten
	 *'hue ' = hue 'sat ' = saturation 'colr' = color
	 *'lum ' = luminosity 'mul ' = multiply 'scrn' = screen 
	 *'diss' = dissolve 'over' = overlay 'hLit' = hard light 'sLit' = soft light
	 *'diff' = difference 'smud' = exclusion 'div ' = color dodge 'idiv' = color burn
	 *'lbrn' = linear burn, 'lddg' = linear dodge, 'vLit' = vivid light
	 *'lLit' = linear light, 'pLit' = pin light, 'hMix' = hard mix
	 *'pass' = pass through, 'dkCl' = darker color, 'lgCl' = lighter color
	 *'fsub' = subtract, 'fdiv' = divide  
	 */
	public class GPsdBlendMode {
		public static const PASS_THROUGH : String = "pass";

		public static function getAS3BlendMode(key : String) : String {
			switch(key) {
				case "norm":
					return BlendMode.NORMAL;
				case "dark":
					return BlendMode.DARKEN;
				case "lite":
					return BlendMode.LIGHTEN;
				case "mul ":
					return BlendMode.MULTIPLY;
				case "scrn":
					return BlendMode.SCREEN;
				case "over":
					return BlendMode.OVERLAY;
				case "diff":
					return BlendMode.DIFFERENCE;
				case "hLit":
					return BlendMode.HARDLIGHT;
				case "lddg":
					return BlendMode.ADD;
				case "fsub":
					return BlendMode.SUBTRACT;
				default:
					trace("blendMode", key);
					return key;
			}
		}
	}
}
