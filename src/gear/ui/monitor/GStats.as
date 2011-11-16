package gear.ui.monitor {
	import gear.render.FrameRender;
	import gear.render.IFrame;
	import gear.ui.core.GBase;
	import gear.ui.data.GStatsData;
	import gear.utils.SystemUtil;

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
	 * @version 20110919
	 */
	public class GStats extends GBase implements IFrame {
		private var _data : GStatsData;
		private var _xml : XML;
		private var _label : TextField;
		private var _time : uint;
		private var _fps : uint;
		private var _ms : uint;
		private var _prev_ms : uint;
		private var _mem : Number;
		private var _maxMem : Number;
		private var _graph : Bitmap;
		private var _rect : Rectangle;
		private var _fps_graph : uint;
		private var _mem_graph : uint;
		private var _maxMem_graph : uint;

		override protected function create() : void {
			_xml = <xml><fps>FPS:</fps><ms>MS:</ms><mem>MEM:</mem><maxMem>MAX:</maxMem></xml>;
			graphics.beginFill(_data.bgColor);
			graphics.drawRect(0, 0, _data.width, _data.height);
			graphics.endFill();
			_label = new TextField();
			_label.width = _data.width;
			_label.height = 50;
			_label.styleSheet = _data.css;
			_label.condenseWhite = true;
			_label.selectable = false;
			_label.mouseEnabled = false;
			addChild(_label);
			_graph = new Bitmap();
			_graph.y = 50;
			_graph.bitmapData = new BitmapData(_data.width, _data.height - 50, false, _data.bgColor);
			_rect = new Rectangle(_data.width - 1, 0, 1, _data.height - 50);
			addChild(_graph);
		}

		override protected function onShow() : void {
			addEventListener(MouseEvent.CLICK, clickHandler);
			FrameRender.instance.add(this);
		}

		override protected function onHide() : void {
			removeEventListener(MouseEvent.CLICK, clickHandler);
			FrameRender.instance.remove(this);
		}

		private function clickHandler(event : MouseEvent) : void {
			SystemUtil.gc();
		}

		public function GStats(data : GStatsData = null) {
			_data = data;
			if (_data == null) {
				_data = new GStatsData();
			}
			super(_data);
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
				_graph.bitmapData.fillRect(_rect, _data.bgColor);
				_graph.bitmapData.setPixel(_graph.width - 1, _graph.height - _fps_graph, _data.fpsColor);
				_graph.bitmapData.setPixel(_graph.width - 1, _graph.height - ((_time - _ms ) >> 1 ), _data.msColor);
				_graph.bitmapData.setPixel(_graph.width - 1, _graph.height - _mem_graph, _data.memColor);
				_graph.bitmapData.setPixel(_graph.width - 1, _graph.height - _maxMem_graph, _data.maxMemColor);
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
