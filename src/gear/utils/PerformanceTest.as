package gear.utils {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.LocalConnection;
	import flash.system.Capabilities;
	import flash.utils.describeType;
	import flash.utils.getTimer;

	public class PerformanceTest {
		protected static var _instance : PerformanceTest;

		public static function getInstance() : PerformanceTest {
			return _instance ? _instance : _instance = new PerformanceTest();
		}

		public var out : Function;
		public var logger : Object;
		public var synchronous : Boolean = false;
		protected var queue : Array;
		protected var _queue : Array;
		protected var div : String;
		protected var _paused : Boolean = false;
		protected var _synchronousTestResults : Number;
		protected var _synchronous : Boolean;
		protected var shape : Shape;

		public function PerformanceTest() {
			init();
		}

		public function get paused() : Boolean {
			return _paused;
		}

		public function set paused(value : Boolean) : void {
			_paused = value;
			if (value) {
				stopTick();
			} else if (queue.length > 0) {
				startTick();
			}
		}

		public function testFunction(testFunction : Function, iterations : uint = 1, name : String = "Function", description : String = null) : void {
			var o : Object = {testSuite:testFunction, iterations:iterations, name:name, description:description, index:0, tare:0, tareCount:-1};
			o.methods = [name];
			addTest(o);
		}

		public function testRender(displayObject : DisplayObject, bounds : Rectangle = null, iterations : uint = 1, name : String = "Render", description : String = null) : void {
			var o : Object = {testSuite:displayObject, iterations:iterations, name:name, description:description, index:0, tare:0, tareCount:-1};
			o.methods = ["tare", "[render]"];

			// if bounds weren't specified then calculate them:
			if (bounds == null) {
				bounds = displayObject.getBounds(displayObject);
			}
			o.bounds = bounds;

			// check to ensure that we can create a large enough BitmapData object:
			try {
				o.bitmapData = new BitmapData(bounds.width, bounds.height, true, 0);
			} catch(e : *) {
				throw(new Error("Specified bounds or displayObject dimensions are too large to render."));
			}

			addTest(o);
		}

		public function testSuite(testSuite : Object, methods : Array = null, iterations : uint = 0, name : String = null, description : String = null) : void {
			if (iterations == 0 && "iterations" in testSuite) {
				iterations = Number(testSuite.iterations);
			}
			if (iterations == 0) {
				iterations = 1;
			}

			var o : Object = {testSuite:testSuite, iterations:iterations, name:name, description:description, index:0, tare:0, tareCount:-1};

			if (description == null && "description" in testSuite) {
				o.description = String(testSuite.description);
			}

			var desc : XML = describeType(testSuite);

			if (name == null && "name" in testSuite) {
				o.name = String(testSuite.name);
			} else {
				o.name = desc.@name.split("::").join(".");
			}

			if (methods != null) {
				o.methods = methods.slice(0);
			} else if ("methods" in testSuite && testSuite.methods is Array) {
				o.methods = testSuite.methods.slice(0);
			} else {
				o.methods = [];
				var methodList : XMLList = desc..method;
				for (var i : int = 0; i < methodList.length(); i++) {
					var methodName : String = methodList[i].@name;

					if (methodName.charAt(0) == "_") {
						continue;
					}
					o.methods.push(methodName);
				}
				o.methods.sort(Array.CASEINSENSITIVE);
			}

			if (o.methods.indexOf("tare") != -1) {
				o.methods.splice(o.methods.indexOf("tare"), 1);
				o.methods.unshift("tare");
				o.tareCount = 0;
			}
			addTest(o);
		}

		public function unitTestFunction(targetTime : uint, testFunction : Function, iterations : uint = 1) : Boolean {
			startSynchronousTest();
			this.testFunction(testFunction, iterations);
			endSynchronousTest();
			return _synchronousTestResults <= targetTime;
		}

		public function unitTestRender(targetTime : uint, displayObject : DisplayObject, bounds : Rectangle = null, iterations : uint = 1) : Boolean {
			startSynchronousTest();
			testRender(displayObject, bounds, iterations);
			endSynchronousTest();
			return _synchronousTestResults <= targetTime;
		}

		public function unitTestSuite(targetTime : uint, testSuite : Object, methods : Array = null, iterations : uint = 0) : Boolean {
			startSynchronousTest();
			this.testSuite(testSuite, methods, iterations);
			endSynchronousTest();
			return _synchronousTestResults <= targetTime;
		}

		protected function init() : void {
			if (queue != null) {
				return;
			}
			queue = [];
			shape = new Shape();
			div = "";
			while (div.length < 72) {
				div += "–";
			}
			if (out == null) {
				out = trace;
			}
		}

		protected function addTest(o : Object) : void {
			queue.push(o);
			if (queue.length == 1) {
				runNext();
			}
		}

		protected function runNext() : void {
			if (queue.length < 1 || _paused) {
				return;
			}
			var o : Object = queue[0];
			getLogger().logBegin(o.name, o.description, o.iterations);

			startTick();
		}

		protected function startSynchronousTest() : void {
			_synchronous = synchronous;
			_synchronousTestResults = 0;
			_queue = queue;
			queue = [];
			synchronous = true;
		}

		protected function endSynchronousTest() : void {
			queue = _queue;
			synchronous = _synchronous;
			if (queue.length) {
				startTick();
			}
		}

		protected function runNextMethod() : void {
			var o : Object = queue[0];
			if (o.index == o.methods.length) {
				finish();
				return;
			}

			var methodName : String = o.methods[o.index];
			var method : Function;

			if (o.testSuite is DisplayObject) {
				method = methodName == "tare" ? renderTare : render;
			} else if (o.testSuite is Function) {
				method = o.testSuite;
			} else if (!(methodName in o.testSuite)) {
				getLogger().logError(methodName, null);
				o.index++;
				runNextMethod();
				return;
			} else {
				method = o.testSuite[methodName];
			}

			try {
				new LocalConnection().connect("_FORCE_GC_");
				new LocalConnection().connect("_FORCE_GC_");
			} catch(e : *) {
			}

			var iterations : int = o.iterations;
			var t : int = getTimer();
			for (var i : int = 0; i < iterations; i++) {
				try {
					method();
				} catch (e : *) {
					o.index++;
					getLogger().logError(methodName, e);
					startTick();
					return;
				}
			}
			t = getTimer() - t;
			if (methodName == "tare") {
				o.tareCount++;
				if (o.tareCount > 1) {
					if (Math.abs(o.tare - t) / t < 0.1 || Math.abs(o.tare - t) <= 2 || o.tareCount > 5) {
						o.index++;
						t = (t + o.tare) / 2;

						getLogger().logMethod(methodName, t, iterations, o.tareCount);
					}
					o.tare = t;
				}
			} else {
				t -= o.tare;
				o.index++;

				getLogger().logMethod(methodName, t, iterations, null);
				_synchronousTestResults += t / iterations;
			}
			startTick();
		}

		protected function finish() : void {
			stopTick();

			getLogger().logEnd(queue[0].name);

			queue.shift();

			runNext();
		}

		protected function tick(evt : Event) : void {
			stopTick();
			runNextMethod();
		}

		protected function startTick() : void {
			if (synchronous) {
				tick(null);
			} else {
				shape.addEventListener(Event.ENTER_FRAME, tick);
			}
		}

		protected function stopTick() : void {
			shape.removeEventListener(Event.ENTER_FRAME, tick);
		}

		protected function getLogger() : Object {
			return logger ? logger : this;
		}

		protected function render() : void {
			var o : Object = queue[0];
			o.bitmapData.fillRect(o.bitmapData.rect, 0);
			var mtx : Matrix = new Matrix(1, 0, 0, 1, -o.bounds.x, -o.bounds.y);
			o.bitmapData.draw(o.testSuite, mtx);
		}

		protected function renderTare() : void {
			var o : Object = queue[0];
			o.bitmapData.fillRect(o.bitmapData.rect, 0);
		}

		protected function logBegin(name : String, description : String, iterations : uint) : void {
			log(div);
			log(pad(name + " (" + iterations + " iterations)", 72));
			log("Player version: " + Capabilities.version + " " + (Capabilities.isDebugger ? "(debug)" : "(regular)"));
			if (description) {
				log(pad(description, 72));
			}
			log(div);
			log(pad("method", 54, ".") + "." + pad("ttl ms", 8, ".", true) + "." + pad("avg ms", 8, ".", true));
		}

		protected function logError(name : String, details : Error) : void {
			if (details == null) {
				log("* " + pad((name == "" ? "" : name + " not found."), 72));
			} else {
				log("* " + name + ": " + String(details));
			}
		}

		protected function logMethod(name : String, time : uint, iterations : uint, details : *) : void {
			if (details != null) {
				log(pad(name + " [" + String(details) + "]", 54) + " " + pad(time, 8, " ", true) + " " + pad(formatNumber(time / iterations), 8, " ", true));
			} else {
				log(pad(name, 54) + " " + pad(time, 8, " ", true) + " " + pad(formatNumber(time / iterations), 8, " ", true));
			}
		}

		protected function logEnd(name : String) : void {
			name;
			log(div);
			log("");
		}

		protected function pad(str : *, cols : uint, char : String = " ", lpad : Boolean = false) : String {
			str = String(str);
			if (str.length > cols) {
				return str.substr(0, cols);
			}
			while (str.length < cols) {
				str = lpad ? char + str : str + char;
			}
			return str;
		}

		protected function log(str : String) : void {
			if (out != null) {
				out(str);
			}
		}

		protected function formatNumber(num : Number, decimal : uint = 2) : String {
			var m : Number = Math.pow(10, decimal);
			var str : String = String((Math.round(num * m) + 0.5) / m);
			return str.substr(0, str.length - 1);
		}
	}
}