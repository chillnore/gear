﻿package gear.utils {
	import gear.gui.bd.GBDList;
	import gear.gui.bd.GBDFrame;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.filters.ConvolutionFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	/**
	 * 位图工具类
	 * 
	 * @author bright
	 * @version 20121112
	 */
	public final class GBDUtil {
		public static function toBD(value:DisplayObject):BitmapData{
			var rect : Rectangle = value.getBounds(value);
			if (rect.width < 1 || rect.height < 1) {
				return null;
			}
			var bd : BitmapData = new BitmapData(rect.width, rect.height, true, 0);
			var mtx : Matrix = new Matrix();
			mtx.translate(Math.floor(-rect.x), Math.floor(-rect.y));
			bd.draw(value, mtx, null, null, null, true);
			return bd;
		}
		
		/**
		 * 转换MovieClip为位图数组
		 */
		public static function mcToBDList(mc : MovieClip) : GBDList {
			if (mc == null) {
				return null;
			}
			var bp : Bitmap;
			var bounds : Rectangle;
			var mtx : Matrix = new Matrix();
			mc.gotoAndStop(1);
			var total : int = mc.totalFrames;
			var list : Vector.<GBDFrame>=new Vector.<GBDFrame>(total, true);
			var bd : BitmapData;
			var offset : Point;
			for (var i : int = 0;i < total ;i++) {
				if (mc.numChildren == 0) {
					mc.nextFrame();
					continue;
				}
				if (mc.numChildren == 1) {
					bp = mc.getChildAt(0) as Bitmap;
					if (bp != null) {
						offset = new Point(bp.x, bp.y);
						bd = cutAlphaBD(bp.bitmapData, offset);
						list[i] = new GBDFrame(offset.x, offset.y, bd);
						mc.nextFrame();
						continue;
					}
				}
				bounds = mc.getBounds(mc);
				if (bounds.width < 1 || bounds.height < 1) {
					continue;
				}
				bd = new BitmapData(bounds.width, bounds.height, true, 0);
				mtx.identity();
				mtx.translate(-bounds.x, -bounds.y);
				if (GSystemUtil.version < 11.3) {
					bd.draw(mc, mtx, null, null, null, true);
				} else {
					bd.drawWithQuality(mc, mtx, null, null, null, true, StageQuality.HIGH_16X16_LINEAR);
				}
				offset = new Point(bounds.x, bounds.y);
				bd = cutAlphaBD(bd, offset);
				list[i] = new GBDFrame(offset.x, offset.y, bd);
				mc.nextFrame();
			}
			return new GBDList(list);
		}

		public static function spriteToBD(skin : Sprite) : GBDFrame {
			if (skin == null || skin.numChildren < 1) {
				return null;
			}
			var bp : Bitmap = skin.getChildAt(0) as Bitmap;
			if (bp != null) {
				bp.bitmapData.lock();
				return new GBDFrame(bp.x, bp.y, bp.bitmapData);
			}
			var rect : Rectangle = skin.getBounds(skin);
			if (rect.width < 1 || rect.height < 1) {
				return null;
			}
			var bd : BitmapData = new BitmapData(rect.width, rect.height, true, 0);
			var mtx : Matrix = new Matrix();
			mtx.translate(Math.floor(-rect.x), Math.floor(-rect.y));
			bd.draw(skin, mtx, null, null, null, true);
			return new GBDFrame(rect.x, rect.y, bd);
		}

		public static function resizeBD(source : BitmapData, w : int, h : int) : BitmapData {
			if (source == null || w == 0 || h == 0) {
				return null;
			}
			var a : Number = w / source.width;
			var d : Number = h / source.height;
			var mtx : Matrix = new Matrix(a, 0, 0, d, 0, 0);
			var target : BitmapData = new BitmapData(w, h, source.transparent, 0);
			target.draw(source, mtx, null, null, null, true);
			return target;
		}

		public static function getThumbBD(bd : BitmapData, w : int, h : int) : BitmapData {
			if (bd == null) {
				return null;
			}
			var rect : Rectangle = bd.getColorBoundsRect(0xFF000000, 0x00000000, false);
			var source : BitmapData;
			var mtx : Matrix = new Matrix();
			var sx : Number;
			var sy : Number;
			var s : Number;
			var tx : int;
			var ty : int;
			if (rect.width == 0 || rect.height == 0) {
				source = bd.clone();
				sx = w / bd.width;
				sy = h / bd.height;
				s = Math.min(Math.min(sx, sy), 1);
			} else {
				source = new BitmapData(rect.width, rect.height, true, 0);
				source.copyPixels(bd, rect, GMathUtil.ZERO_POINT);
				sx = w / rect.width;
				sy = h / rect.height;
				s = Math.min(Math.min(sx, sy), 1);
				tx = (w - rect.width * s) >> 1;
				ty = (h - rect.height * s) >> 2;
			}
			mtx.scale(s, s);
			mtx.translate(tx, ty);
			var target : BitmapData = new BitmapData(w, h, true, 0);
			target.draw(source, mtx, null, null, null, true);
			source.dispose();
			return target;
		}

		public static function getCutRect(source : BitmapData) : Rectangle {
			return source.getColorBoundsRect(0xFF000000, 0x00000000, false);
		}

		/**
		 * 按格子切图
		 */
		public static function cutGridBD(source : BitmapData, gw : int, gh : int, ox : int = 0, oy : int = 0, filters : Array = null) : GBDList {
			if (source == null) {
				return null;
			}
			var row : int = source.width / gw;
			var col : int = source.height / gh;
			if (ox == 0) {
				ox = -gw * 0.5;
			}
			if (oy == 0) {
				oy = -gh * 0.5;
			}
			var list : Vector.<GBDFrame> = new Vector.<GBDFrame>();
			var clip : BitmapData;
			var rect : Rectangle = new Rectangle(0, 0, gw, gh);
			var offset : Point = new Point();
			var c : int;
			var r : int;
			var next : int = 0;
			for (r = 0;r < row;r++) {
				if (filters != null && filters.indexOf(c) != -1) {
					continue;
				}
				rect.x = r * gw;
				for (c = 0;c < col;c++) {
					rect.y = c * gh;
					clip = new BitmapData(rect.width, rect.height, true, 0);
					clip.copyPixels(source, rect, GMathUtil.ZERO_POINT);
					offset.setTo(ox, oy);
					clip = cutAlphaBD(clip, offset);
					list[next++] = new GBDFrame(offset.x, offset.y, clip);
				}
			}
			return new GBDList(list);
		}

		/**
		 * 切掉透明像素,释放源图，并重算偏移
		 */
		public static function cutAlphaBD(source : BitmapData, point : Point) : BitmapData {
			if (source == null || !source.transparent) {
				return source;
			}
			var rect : Rectangle = source.getColorBoundsRect(0xFF000000, 0x00000000, false);
			if (rect.equals(source.rect)) {
				return source;
			}
			var bd : BitmapData = new BitmapData(rect.width, rect.height, true, 0);
			bd.copyPixels(source, rect, GMathUtil.ZERO_POINT);
			source.dispose();
			point.x += rect.x;
			point.y += rect.y;
			return bd;
		}

		/**
		 * 使用选定的压缩程序算法压缩此 BitmapData 对象，并返回一个新 ByteArray 对象。
		 */
		public static function encodeBD(source : BitmapData, compressor : Object) : ByteArray {
			var output : ByteArray = new ByteArray();
			source.encode(source.rect, compressor, output);
			return output;
		}

		/**
		 * 切割竖条位图数组
		 */
		public static function cutBD(source : BitmapData, widths : Vector.<uint>) : GBDList {
			if (source == null || widths == null || widths.length < 1) {
				return null;
			}
			var list : Vector.<GBDFrame> = new Vector.<GBDFrame>(widths.length, true);
			var bd : BitmapData;
			var rect : Rectangle = new Rectangle();
			rect.height = source.height;
			for (var i : int = 0;i < widths.length;i++) {
				rect.width = widths[i];
				bd = new BitmapData(rect.width, rect.height, true, 0);
				bd.copyPixels(source, rect, GMathUtil.ZERO_POINT);
				rect.x += rect.width;
				list[i] = new GBDFrame(0, 0, bd);
			}
			return new GBDList(list);
		}

		public static function toGaryBD(source : BitmapData) : BitmapData {
			if (source == null) {
				return null;
			}
			var bd : BitmapData = source.clone();
			bd.applyFilter(bd, bd.rect, bd.rect.topLeft, GColorMatrixUtil.GRAY_FILTER);
			return bd;
		}

		public static function applySharpen(bd : BitmapData) : void {
			var amount : Number = 3;
			var a : Number = amount / -100;
			var b : Number = a * (-8) + 1;
			var mtx : Array = [a, a, a, a, b, a, a, a, a];
			var sharpen : ConvolutionFilter = new ConvolutionFilter(3, 3, mtx);
			bd.applyFilter(bd, bd.rect, bd.rect.topLeft, sharpen);
		}

		public static function createRef(p_source : DisplayObject) : void {
			var bd : BitmapData = new BitmapData(p_source.width, p_source.height, true, 0);
			var mtx : Matrix = new Matrix();
			mtx.d = -1;
			mtx.ty = bd.height;
			bd.draw(p_source, mtx);
			var width : int = bd.width;
			var height : int = bd.height;
			mtx = new Matrix();
			mtx.createGradientBox(width, height, 0.5 * Math.PI);
			var shape : Shape = new Shape();
			shape.graphics.beginGradientFill(GradientType.LINEAR, [0, 0], [0.9, 0.2], [0, 0xFF], mtx);
			shape.graphics.drawRect(0, 0, width, height);
			shape.graphics.endFill();
			var mask_bd : BitmapData = new BitmapData(width, height, true, 0);
			mask_bd.draw(shape);
			bd.copyPixels(bd, bd.rect, GMathUtil.ZERO_POINT, mask_bd, GMathUtil.ZERO_POINT, false);
			var ref : Bitmap = new Bitmap();
			ref.y = p_source.height;
			ref.bitmapData = bd;
			p_source.parent.addChild(ref);
		}

		public function createMaskFromBitmap(value : BitmapData) : BitmapData {
			var bd : BitmapData = new BitmapData(value.width, value.height, true, 0xFF000000);
			bd.copyChannel(value, value.rect, value.rect.topLeft, BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
			bd.threshold(bd, bd.rect, bd.rect.topLeft, "<", 0x6F000000, 0, 0xFF000000, true);
			var bp : Bitmap = new Bitmap(bd);
			bp.filters = [new BlurFilter(1.5, 1.5, BitmapFilterQuality.LOW)];
			bd.draw(bp);
			return bd;
		}

		public static function getSize(value : DisplayObject) : Rectangle {
			var rect : Rectangle = value.getBounds(value);
			var bd : BitmapData = new BitmapData(rect.width, rect.height, true, 0);
			var mtx : Matrix = new Matrix();
			mtx.translate(Math.floor(-rect.x), Math.floor(-rect.y));
			bd.draw(value, mtx);
			rect = bd.getColorBoundsRect(0xFF000000, 0x00000000, false);
			bd.dispose();
			return rect;
		}

		public static function mergeBDUnit(value : Array) : GBDFrame {
			var source : GBDFrame = GBDFrame(value[0]).clone();
			var s_rect : Rectangle = source.bound;
			var total : int = value.length;
			var target : GBDFrame;
			var t_rect : Rectangle;
			var u_rect : Rectangle;
			for (var i : int = 1;i < total;i++) {
				target = value[i];
				if (target == null) {
					continue;
				}
				t_rect = target.bound;
				if (!s_rect.containsRect(t_rect)) {
					u_rect = s_rect.union(t_rect);
					source.resetBD(s_rect.x - u_rect.x, s_rect.y - u_rect.y, u_rect.width, u_rect.height);
					source.mergeBD(t_rect.x - u_rect.x, t_rect.y - u_rect.y, target);
				} else {
					source.mergeBD(t_rect.x - s_rect.x, t_rect.y - s_rect.y, target);
				}
			}
			return source;
		}

		public static function scale9(source : BitmapData, scale9 : Rectangle, width : int, height : int) : BitmapData {
			if (source == null) {
				return null;
			}
			if (source.width == width && source.height == height) {
				return source;
			}
			if (width < 1 || height < 1) {
				return null;
			}
			width = Math.max(width, source.width - scale9.width);
			height = Math.max(height, source.height - scale9.height);
			var target : BitmapData = new BitmapData(width, height, source.transparent, 0x0);
			var rows : Array = [0, scale9.top, scale9.bottom, source.height];
			var cols : Array = [0, scale9.left, scale9.right, source.width];
			var newRows : Array = [0, scale9.top, height - (source.height - scale9.bottom), height];
			var newCols : Array = [0, scale9.left, width - (source.width - scale9.right), width];
			var newRect : Rectangle;
			var clipRect : Rectangle;
			var mtx : Matrix = new Matrix();
			for (var i : int = 0; i < 3; i++) {
				for (var j : int = 0; j < 3; j++) {
					newRect = new Rectangle(cols[i], rows[j], cols[i + 1] - cols[i], rows[j + 1] - rows[j]);
					clipRect = new Rectangle(newCols[i], newRows[j], newCols[i + 1] - newCols[i], newRows[j + 1] - newRows[j]);
					mtx.identity();
					mtx.a = clipRect.width / newRect.width;
					mtx.d = clipRect.height / newRect.height;
					mtx.tx = clipRect.x - newRect.x * mtx.a;
					mtx.ty = clipRect.y - newRect.y * mtx.d;
					target.draw(source, mtx, null, null, clipRect, false);
				}
			}
			return target;
		}
	}
}