package gear.gui.controls {
	import gear.gui.core.GBase;
	import gear.gui.skins.IGSkin;
	import gear.gui.utils.GUIUtil;
	import gear.net.GLoadUtil;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.engine.ContentElement;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.GraphicElement;
	import flash.text.engine.GroupElement;
	import flash.text.engine.TextBaseline;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextElement;
	import flash.text.engine.TextLine;
	/**
	 * @author bright
	 */
	public class GRichTextArea extends GBase {
		protected var _bgSkin:IGSkin;
		protected var _context:Sprite;
		protected var _max : int;
		protected var _scrollBar:GVScrollBar;
		protected var _list:Vector.<ContentElement>;
		
		override protected function preinit():void{
			_list=new Vector.<ContentElement>();
			setSize(100,100);
		}
		
		override protected function create():void{
			var change:TextElement=new TextElement("[世界]",getFormat(0x0a0a0a));
			var format:ElementFormat = new ElementFormat();
			format.dominantBaseline = TextBaseline.DESCENT;
			var bd:BitmapData=GLoadUtil.getImg("blue_light.png");
			var face:GraphicElement=new GraphicElement(new Bitmap(bd),bd.width,bd.height,format);
			var name:TextElement=new TextElement("gh中文",getFormat(0x0a0a0a));
			_list.push(change);
			_list.push(face);
			_list.push(name);
			appendGroup();
		}
		
		protected function refresh():void{
		}
		
		protected function appendGroup():void{
			var textBlock:TextBlock=new TextBlock();
			textBlock.content=new GroupElement(_list);
			textBlock.baselineZero=TextBaseline.DESCENT;
			var textLine:TextLine = textBlock.createTextLine (null,_width);
			var xPos:int=5;
			var yPos:int=25;
			while(textLine!=null){
				textLine.x=xPos;
				textLine.y=yPos;
				addChild(textLine);
				textLine=textBlock.createTextLine(textLine,_width);
			}
		}
		
		protected function getFormat(color:uint):ElementFormat{
			var format:ElementFormat=new ElementFormat(new FontDescription(GUIUtil.defaultFont),GUIUtil.defaultFontSize);
			format.color=color;
			return format;
		}

		public function GRichTextArea() {
		}
		
		public function append():void{
		}
	}
}
