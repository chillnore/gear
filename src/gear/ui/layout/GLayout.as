package gear.ui.layout {
	import gear.ui.containers.GPanel;
	import gear.ui.core.GAlign;
	import gear.ui.core.GAlignMode;
	import gear.ui.core.GBase;
	import gear.ui.manager.UIManager;

	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * 布局管理器
	 * 
	 * @author bright
	 * @version 20101019
	 */
	public class GLayout {
		public static function getRect(target : DisplayObject, align : GAlign) : Rectangle {
			if (target == null || align == null) {
				return null;
			}
			var w : int;
			var h : int;
			var parent : DisplayObject = target.parent;
			if (parent == null || parent == UIManager.root) {
				w = UIManager.stageWidth;
				h = UIManager.stageHeight;
			} else if (parent is GPanel) {
				w = parent.width - (GPanel(parent).padding << 1);
				h = parent.height - (GPanel(parent).padding << 1);
			}
			var rect : Rectangle = new Rectangle(0, 0, target.width, target.height);
			var l : int = align.left;
			var r : int = align.right;
			var t : int = align.top;
			var b : int = align.bottom;
			var hc : int = align.horizontalCenter;
			var vc : int = align.verticalCenter;
			if (l != -1) {
				rect.x = l;
				if (r != -1) {
					rect.width = w - l - r;
				}
			} else if (r != -1) {
				rect.x = w - target.width - r;
			} else if (hc != -1) {
				rect.x = ((w - target.width) >> 1) + hc;
			}
			if (t != -1) {
				rect.y = t;
				if (b != -1) {
					rect.height = h - t - b;
				}
			} else if (b != -1) {
				rect.y = h - target.height - b;
			} else if (vc != -1) {
				rect.y = ((h - target.height) >> 1) + vc;
			}
			return rect;
		}

		public static function update(parent : DisplayObject, target : GBase) : void {
			if (parent == null || target == null) {
				return;
			}
			var a : GAlign = target.align;
			if (a == null) {
				return;
			}
			var w : int;
			var h : int;
			if (parent == UIManager.root) {
				w = UIManager.stageWidth;
				h = UIManager.stageHeight;
			} else if (parent is GPanel) {
				w = parent.width - (GPanel(parent).padding << 1);
				h = parent.height - (GPanel(parent).padding << 1);
			} else {
				w = parent.width;
				h = parent.height;
			}
			var l : int = a.left;
			var r : int = a.right;
			var t : int = a.top;
			var b : int = a.bottom;
			var hc : int = a.horizontalCenter;
			var vc : int = a.verticalCenter;
			if (l != -1) {
				target.x = l;
				if (r != -1) {
					target.width = w - l - r;
				}
			} else if (r != -1) {
				target.x = w - target.width - r;
			} else if (hc != -1) {
				target.x = ((w - target.width) >> 1) + hc;
			}
			if (t != -1) {
				target.y = t;
				if (b != -1) {
					target.height = h - t - b;
				}
			} else if (b != -1) {
				target.y = h - target.height - b;
			} else if (vc != -1) {
				target.y = ((h - target.height) >> 1) + vc;
			}
		}

		public static function layout(target : DisplayObject, align : GAlign = null) : void {
			if (target == null || target.parent == null) {
				return;
			}
			var a : GAlign = align;
			if (a == null && target is GBase) {
				a = GBase(target).align;
			}
			if (a == null) {
				return;
			}
			var w : int;
			var h : int;
			if (target.parent == UIManager.root) {
				w = UIManager.stageWidth;
				h = UIManager.stageHeight;
			} else if (target.parent.name == "content") {
				var panel : GPanel = GPanel(target.parent.parent);
				w = panel.width - panel.padding * 2;
				h = panel.height - panel.padding * 2;
			} else if (target.scrollRect != null) {
				w = target.scrollRect.right;
				h = target.scrollRect.bottom;
			} else {
				w = target.parent.width;
				h = target.parent.height;
			}
			var l : int = a.left;
			var r : int = a.right;
			var t : int = a.top;
			var b : int = a.bottom;
			var hc : int = a.horizontalCenter;
			var vc : int = a.verticalCenter;
			if (l != -1) {
				target.x = l;
				if (r != -1) {
					target.width = w - l - r;
				}
			} else if (r != -1) {
				target.x = w - target.width - r;
			} else if (hc != -1) {
				target.x = ((w - target.width) >> 1) + hc;
			}
			if (t != -1) {
				target.y = t;
				if (b != -1) {
					target.height = h - t - b;
				}
			} else if (b != -1) {
				target.y = h - target.height - b;
			} else if (vc != -1) {
				target.y = ((h - target.height) >> 1) + vc;
			}
		}

		public static function layoutTip(source : DisplayObject, target : DisplayObject, mode : int, hgap : int = 3, vgap : int = 3, pointX : int = 0, pointY : int = 0) : void {
			if (source == null || target == null) {
				return;
			}
			var newX : int = 0;
			var newY : int = 0;
			var p : Point = source.localToGlobal(new Point(pointX, pointY));
			var w : int = UIManager.stageWidth;
			var h : int = UIManager.stageHeight;
			switch(mode) {
				case GAlignMode.TOP_LEFT:
					newX = p.x - target.width - hgap;
					newY = p.y - target.height - vgap;
					if (newX < 0) {
						newX = 0;
					}
					if (newY < 0) {
						newY = p.y + source.height + vgap;
					}
					break;
				case GAlignMode.TOP:
					newX = p.x + ((source.width - target.width) >> 1);
					newY = p.y - target.height - vgap;
					if (newX < 0) {
						newX = 0;
					} else if (newX + target.width > w) {
						newX = w - target.width;
					}
					if (newY < 0) {
						newY = p.y + source.height + vgap;
					}
					break;
				case GAlignMode.TOP_RIGHT:
					newX = p.x + source.width + hgap;
					newY = p.y - target.height - vgap;
					if (newX + target.width > w) {
						newX = w - target.width;
					}
					break;
				case GAlignMode.LEFT:
					newX = p.x - target.width - hgap;
					newY = p.y;
					if (newX < 0) {
						newX = p.x + source.width + hgap;
					}
					if (newY + target.height > h) {
						newY = h - target.height;
					}
					break;
				case GAlignMode.RIGHT:
					newX = p.x + source.width + hgap;
					newY = p.y;
					if (newX + target.width > w) {
						newX = p.x - target.width - hgap;
					}
					if (newY + target.height > h) {
						newY = h - target.height;
					}
					break;
				case GAlignMode.BOTTOM_LEFT:
					newX = p.x - target.width - hgap;
					newY = p.y + source.height + vgap;
					if (newX < 0) {
						newX = 0;
					}
					if (newY + target.height > h) {
						newY = p.y - target.height - vgap;
					}
					break;
				case GAlignMode.BOTTOM:
					newX = p.x + ((source.width - target.width) >> 1);
					newY = p.y + source.height + vgap;
					if (newX < 0) {
						newX = 0;
					} else if (newX + target.width > w) {
						newX = w - target.width;
					}
					if (newY + target.height > h) {
						newY = p.y - target.height - vgap;
					}
					break;
				case GAlignMode.BOTTOM_RIGHT:
					newX = p.x + source.width + hgap;
					newY = p.y + source.height + vgap;
					if (newX < 0) {
						newX = 0;
					} else if (newX + target.width > w) {
						newX = p.x - target.width - hgap;
					}
					if (newY + target.height > h) {
						newY = Math.max(0, p.y - target.height - vgap);
					}
					break;
				default:
					break;
			}
			target.x = newX;
			target.y = newY;
		}
	}
}
