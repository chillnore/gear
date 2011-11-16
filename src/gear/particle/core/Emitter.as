package gear.particle.core {
	import gear.particle.action.IAction;
	import gear.particle.counter.ICounter;
	import gear.particle.counter.ZeroCounter;
	import gear.particle.init.IInit;
	import gear.pool.ObjectPool;
	import gear.render.FrameRender;
	import gear.render.IFrame;

	import flash.display.BitmapData;

	/**
	 * @author Administrator
	 */
	public class Emitter implements IFrame {
		protected var _delay : int;
		protected var _offset : int;
		protected var _particles : Array;
		protected var _inits : Vector.<IInit>;
		protected var _actions : Vector.<IAction>;
		protected var _pool : ObjectPool;
		protected var _counter : ICounter;
		protected var _running : Boolean;
		protected var _output : BitmapData;

		protected function createParticle() : void {
			var particle : Particle = Particle(_pool.getObject());
			var len : int = _inits.length;
			for (var i : int = 0;i < len;++i) {
				_inits[i].init(this, particle);
			}
			_particles.push(particle);
		}

		protected function comparePriority(source : IBehaviour, target : IBehaviour) : Number {
			return source.priority - target.priority;
		}

		protected function getInitIndex(value : IBehaviour) : int {
			var left : int = 0;
			var right : int = _actions.length - 1;
			var result : int;
			while (left <= right) {
				var mid : int = (left + right) >> 1;
				result = comparePriority(value, _inits[mid]);
				if (result > 0) {
					left = mid + 1;
				} else {
					right = mid - 1;
				}
			}
			return left;
		}

		protected function getActionIndex(value : IBehaviour) : int {
			var left : int = 0;
			var right : int = _actions.length - 1;
			var result : int;
			while (left <= right) {
				var mid : int = (left + right) >> 1;
				result = comparePriority(value, _actions[mid]);
				if (result > 0) {
					left = mid + 1;
				} else {
					right = mid - 1;
				}
			}
			return left;
		}

		public function Emitter(delay : int = 33) : void {
			_delay = delay;
			_particles = new Array();
			_inits = new Vector.<IInit>();
			_actions = new Vector.<IAction>();
			_pool = new ObjectPool(Particle);
			_running = false;
			_counter = new ZeroCounter();
		}

		public function addInit(value : IInit) : void {
			_inits.splice(getInitIndex(value), 0, value);
			value.addedToEmitter(this);
		}

		public function addAction(action : IAction) : void {
			_actions.splice(getActionIndex(action), 0, action);
			action.addedToEmitter(this);
		}

		public function set counter(value : ICounter) : void {
			_counter = value;
			_counter.startEmitter(this);
		}

		public function get running() : Boolean {
			return _running;
		}

		public function set output(value : BitmapData) : void {
			_output = value;
		}

		public function start() : void {
			_running = true;
			var len : int = _counter.startEmitter(this);
			for (var i : int = 0; i < len; ++i ) {
				createParticle();
			}
			if (_output != null) {
				FrameRender.instance.add(this);
			}
		}

		public function update() : void {
			var i : int;
			var len : int = _counter.updateEmitter(this, FrameRender.elapsed);
			var particle : Particle;
			for ( i = 0; i < len; ++i ) {
				createParticle();
			}
			if ( _particles.length > 0 ) {
				len = _actions.length;
				var action : IAction;
				var len2 : int = _particles.length;
				var j : int;
				for ( j = 0; j < len; ++j ) {
					action = _actions[j];
					for ( i = len2 - 1; i >= 0; --i ) {
						particle = _particles[i];
						action.update(this, particle, FrameRender.elapsed);
					}
				}
				for ( i = len2; i--; ) {
					particle = _particles[i];
					if ( particle.isDead ) {
						_particles.splice(i, 1);
						particle.reset();
						_pool.returnObject(particle);
					}
				}
			}
		}

		public function skipFrame(frame : int) : void {
			FrameRender.elapsed = _delay;
			_counter.startEmitter(this);
			for (var i : int = 0;i < frame;i++) {
				update();
			}
		}

		public function refresh() : void {
			if ( !_running ) {
				return;
			}
			if (_delay > 33) {
				_offset += FrameRender.elapsed;
				if (_offset < _delay) {
					return;
				}
				_offset -= _delay;
				_offset %= _delay;
			}
			update();
			_output.lock();
			_output.fillRect(_output.rect, 0);
			var particle : Particle;
			for each (particle in _particles) {
				particle.render(_output, 0, 0);
			}
			_output.unlock();
		}
	}
}
