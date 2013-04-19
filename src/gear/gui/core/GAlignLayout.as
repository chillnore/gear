package gear.gui.core {
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.text.TextField;

	/**
	 * 布局管理器
	 * 
	 * @author bright
	 * @version 20121128
	 */
	public final class GAlignLayout {
		/**
		 * 根据父容器尺寸进行布局
		 */
		public static function layout(source : DisplayObject, align : GAlign = null) : void {
			if (source == null || source.stage == null) {
				return;
			}
			if (align == null && source is GBase) {
				align = GBase(source).align;
			}
			if (align == null) {
				return;
			}
			var tx : int = 0;
			var ty : int = 0;
			var tw : int;
			var th : int;
			var base : GBase;
			var parent : DisplayObject = source.parent;
			if (parent == source.stage.loaderInfo.content || parent is Stage) {
				tw = source.stage.stageWidth;
				th = source.stage.stageHeight;
			} else if (parent.name == "content") {
				base = GBase(source.parent.parent);
				tw = base.width - base.padding.left - base.padding.right;
				th = base.height - base.padding.top - base.padding.bottom;
			} else if (parent is GBase) {
				base = GBase(source.parent);
				tx = base.padding.left;
				ty = base.padding.top;
				tw = base.width - base.padding.left - base.padding.right;
				th = base.height - base.padding.top - base.padding.bottom;
			} else {
				tw = parent.width;
				th = parent.height;
			}
			var l : int = align.left;
			var r : int = align.right;
			var t : int = align.top;
			var b : int = align.bottom;
			var hc : int = align.horizontalCenter;
			var vc : int = align.verticalCenter;
			if (l != -1) {
				source.x = l + tx;
				if (r != -1) {
					source.width = tw - l - r;
				}
			} else if (r != -1) {
				source.x = tw - source.width - r + tx;
			} else if (hc != -1) {
				source.x = ((tw - source.width) >> 1) + hc + tx;
			}
			if (t != -1) {
				source.y = t + ty;
				if (b != -1) {
					source.height = th - t - b;
				}
			} else if (b != -1) {
				source.y = th - source.height - b + ty;
			} else if (vc != -1) {
				source.y = ((th - source.height) >> 1) + vc + ty;
			}
		}

		public static function layoutTarget(source : DisplayObject, target : Object, mode : int, hgap : int = 0, vgap : int = 0) : void {
			var sw : int = source.width;
			var sh : int = source.height;
			if (source is TextField) {
				sw = TextField(source).textWidth + 3;
				sh = TextField(source).textHeight + 1;
			}
			var tx : int = target.x;
			var ty : int = target.y;
			var tw : int = target.width;
			var th : int = target.height;
			if (target is TextField) {
				tw = TextField(source).textWidth + 3;
				th = TextField(source).textHeight + 1;
			}
			switch(mode) {
				case GAlignMode.BEVEL_TOP_LEFT:
					source.x = tx - sw - hgap;
					source.y = ty - sh - vgap;
					break;
				case GAlignMode.TOP_LEFT:
					source.x = tx;
					source.y = ty - sh - vgap;
					break;
				case GAlignMode.TOP_CENTER:
					source.x = tx + ((tw - sw) >> 1);
					source.y = ty - sh - vgap;
					break;
				case GAlignMode.TOP_RIGHT:
					source.x = tx + tw - sw;
					source.y = ty - sh - vgap;
					break;
				case GAlignMode.BEVEL_TOP_RIGHT:
					source.x = tx + tw + hgap;
					source.y = ty - sh - vgap;
					break;
				case GAlignMode.LEFT_TOP:
					source.x = tx - sw - hgap;
					source.y = ty;
					break;
				case GAlignMode.LEFT_CENTER:
					source.x = tx - sw - hgap;
					source.y = ty + ((th - sh) >> 1);
					break;
				case GAlignMode.LEFT_BOTTOM:
					source.x = tx - sw - hgap;
					source.y = ty + th - sh;
					break;
				case GAlignMode.CENTER:
					source.x = tx + ((tw - sw) >> 1);
					source.y = ty + ((th - sh) >> 1);
					break;
				case GAlignMode.RIGHT_TOP:
					source.x = tx + tw + hgap;
					source.y = ty;
					break;
				case GAlignMode.RIGHT_CENTER:
					source.x = tx + tw + hgap;
					source.y = ty + ((th - sh) >> 1);
					break;
				case GAlignMode.RIGHT_BOTTOM:
					source.x = tx + tw + hgap;
					source.y = ty + th - sh;
					break;
				case GAlignMode.BEVEL_BOTTOM_LEFT:
					source.x = tx - sw - hgap;
					source.y = ty + th + vgap;
					break;
				case GAlignMode.BOTTOM_LEFT:
					source.x = tx;
					source.y = ty + th + vgap;
					break;
				case GAlignMode.BOTTOM_CENTER:
					source.x = tx + ((tw - sw) >> 1);
					source.y = ty + th + vgap;
					break;
				case GAlignMode.BOTTOM_RIGHT:
					source.x = tx + tw - sw;
					source.y = ty + th + vgap;
					break;
				case GAlignMode.BEVEL_BOTTOM_RGIHT:
					source.x = tx + tw + hgap;
					source.y = ty + th + vgap;
					break;
			}
		}
	}
}
