package gear.render {
	import gear.particle.action.Move;
	import gear.particle.action.RandomDrift;
	import gear.particle.core.Emitter;
	import gear.particle.counter.Steady;
	import gear.particle.init.Position;
	import gear.particle.init.ScaleInit;
	import gear.particle.init.SharedImage;
	import gear.particle.init.Velocity;
	import gear.particle.shape.RadialDot;
	import gear.particle.zone.DeathZone;
	import gear.particle.zone.LineZone;
	import gear.particle.zone.PointZone;
	import gear.particle.zone.RectZone;

	import flash.display.BitmapData;
	import flash.geom.Point;

	/**
	 * @author bright
	 * @version 20111024
	 */
	public class World2C {
		protected var _output_bd : BitmapData;
		protected var _camera : Camera2C;
		protected var _weather : Emitter;
		protected var _list : Vector.<Render2C>;
		protected var _depth : DepthSort;

		// TODO
		protected function snow() : void {
			_weather.counter = new Steady(20);
			_weather.addInit(new Position(new LineZone(new Point(-5, -5), new Point(805, 5))));
			_weather.addInit(new Velocity(new PointZone(new Point(0, 0.2))));
			_weather.addInit(new SharedImage(new RadialDot(3)));
			_weather.addInit(new ScaleInit(0.75, 1.5));
			_weather.addAction(new Move());
			_weather.addAction(new DeathZone(new RectZone(-10, -10, 820, 590), true));
			_weather.addAction(new RandomDrift(0.5, 0));
			_weather.skipFrame(50);
		}

		public function World2C(output : BitmapData, camera : Camera2C) {
			_output_bd = output;
			_camera = camera;
			_weather = new Emitter();
			_list = new Vector.<Render2C>();
			_depth = new DepthSort(_list);
			FrameRender.instance.onLast = render;
		}

		public function add(value : Render2C) : void {
			_depth.add(value);
		}

		public function remove(value : Render2C) : void {
			_depth.remove(value);
		}

		public function resetDepth(value : Render2C) : void {
			_depth.reset(value);
		}

		public function render() : void {
			_camera.render();
			var cx : int = _camera.offsetX;
			var cy : int = _camera.offsetY;
			_output_bd.lock();
			_output_bd.fillRect(_output_bd.rect, 0);
			var render2c : Render2C;
			for each (render2c in _list) {
				render2c.render(_output_bd, cx, cy);
			}
			_output_bd.unlock();
		}
	}
}
