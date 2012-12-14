package gear.gui.controls {
	import gear.gui.core.GBase;
	import gear.gui.core.GScaleMode;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * 图标控件
	 * 
	 * @author bright
	 * @version 20121204
	 */
	public class GIcon extends GBase{
		protected var _bitmap:Bitmap;
		protected var _bitmapData:BitmapData;
		protected var _scale9Grid:BitmapData;
		
		override protected function preinit():void{
			_scaleMode=GScaleMode.FIT_SIZE;
		}
		
		override protected function create():void{
			_bitmap=new Bitmap();
			addChild(_bitmap);
		}
		
		protected function update():void{
			_bitmap.bitmapData=_bitmapData;
		}
		
		public function GIcon(){
		}
		
		public function set bitmapData(value:BitmapData):void{
			if(_bitmapData==value){
				return;
			}
			_bitmapData=value;
			addRender(update);
			if(_scaleMode==GScaleMode.FIT_SIZE){
				forceSize(_bitmapData.width,_bitmapData.height);
			}
		}
	}
}
