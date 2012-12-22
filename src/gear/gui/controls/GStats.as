package gear.gui.controls {
	import gear.gui.utils.GUIUtil;
	import flash.text.StyleSheet;
	import gear.gui.core.GBase;
	import gear.render.GFrameRender;
	import gear.render.IGFrame;
	import gear.utils.GSystemUtil;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.text.TextField;
	import flash.utils.getTimer;

	/**
	 * GStatus 性能监视器
	 * 
	 * @author bright
	 * @version 20121210
	 */
	public class GStats extends GBase implements IGFrame {
		private var _bgColor:uint;
		private var _fpsColor:uint;
		private var _msColor:uint;
		private var _memColor:uint;
		private var _maxMemColor:uint;
		private var _xml : XML;
		private var _rect : Rectangle;
		private var _label : TextField;
		private var _graph : Bitmap;
		private var _time : uint;
		private var _fps : uint;
		private var _ms : uint;
		private var _prev_ms : uint;
		private var _mem : Number;
		private var _maxMem : Number;
		private var _fps_graph : uint;
		private var _mem_graph : uint;
		private var _maxMem_graph : uint;
		
		override protected function preinit():void{
			_isTop=true;
			_bgColor = 0x000033;
			_fpsColor = 0xffff00;
			_msColor = 0x00ff00;
			_memColor = 0x00ffff;
			_maxMemColor = 0xff0070;
			_xml = <xml><fps>FPS:</fps><ms>MS:</ms><mem>MEM:</mem><maxMem>MAX:</maxMem></xml>;
			_rect=new Rectangle();
			setSize(70,100);
		}

		override protected function create() : void {			
			_label = new TextField();
			_label.height = 50;
			var css:StyleSheet= new StyleSheet();
			css.setStyle("xml", {fontSize:'9px', fontFamily:GUIUtil.defaultFont, leading:'-2px'});
			css.setStyle("fps", {color:"#" + _fpsColor.toString(16)});
			css.setStyle("ms", {color:"#" + _msColor.toString(16)});
			css.setStyle("mem", {color:"#" + _memColor.toString(16)});
			css.setStyle("maxMem", {color:"#" + _maxMemColor.toString(16)});
			_label.styleSheet = css;
			_label.condenseWhite = true;
			_label.selectable = false;
			_label.mouseEnabled = false;
			addChild(_label);
			_graph = new Bitmap();
			_graph.y = 50;
			addChild(_graph);
		}
		
		override protected function resize():void{
			graphics.clear();
			graphics.beginFill(_bgColor);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
			_label.width=_width;
			if(_graph.bitmapData!=null){
				_graph.bitmapData.dispose();
			}
			_graph.bitmapData = new BitmapData(_width, _height - 50, false, _bgColor);
			_rect.setTo(_width - 1, 0, 1, _height - 50);
		}

		override protected function onShow() : void {
			addEvent(this,MouseEvent.CLICK, clickHandler);
			GFrameRender.instance.add(this);
		}

		override protected function onHide() : void {
			GFrameRender.instance.remove(this);
		}

		private function clickHandler(event : MouseEvent) : void {
			GSystemUtil.gc();
		}

		public function GStats() {
		}

		public function refresh() : void {
			_time = getTimer();
			if (_time - 1000 > _prev_ms) {
				_prev_ms = _time;
				_mem = Number((System.totalMemory * 0.000000954).toFixed(3));
				_maxMem = _maxMem > _mem ? _maxMem : _mem;
				_fps_graph = Math.min(_graph.height, (_fps / stage.frameRate) * _graph.height);
				_mem_graph = Math.min(_graph.height, Math.sqrt(Math.sqrt(_mem * 5000))) - 2;
				_maxMem_graph = Math.min(_graph.height, Math.sqrt(Math.sqrt(_maxMem * 5000))) - 2;
				_graph.bitmapData.lock();
				_graph.bitmapData.scroll(-1, 0);
				_graph.bitmapData.fillRect(_rect, _bgColor);
				var px:int=_graph.width - 1;
				_graph.bitmapData.setPixel(px, _graph.height - _fps_graph, _fpsColor);
				_graph.bitmapData.setPixel(px, _graph.height - ((_time - _ms ) >> 1 ), _msColor);
				_graph.bitmapData.setPixel(px, _graph.height - _mem_graph, _memColor);
				_graph.bitmapData.setPixel(px, _graph.height - _maxMem_graph, _maxMemColor);
				_graph.bitmapData.unlock();
				_xml.fps = "FPS: " + _fps + " / " + stage.frameRate;
				_xml.mem = "MEM: " + _mem;
				_xml.maxMem = "MAX: " + _maxMem;
				_fps = 0;
			}
			_fps++;
			_xml.ms = "MS: " + (_time - _ms);
			_ms = _time;
			_label.htmlText = _xml;
		}
	}
}