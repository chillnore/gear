package gear.sound {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;

	/**
	 * SoundItem
	 * 
	 * @author bright
	 * @version 20100110
	 */
	public final class SoundItem extends EventDispatcher {
		private var _sound : Sound;
		private var _isLoop : Boolean;
		private var _channel : SoundChannel;
		private var _volume : Number;
		private var _time : Number;
		private var _soundName : String;

		private function soundCompleteHandler(event : Event) : void {
			if (_isLoop) {
				_channel.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
				_channel = null;
				_time = 0;
				play();
			} else {
				_channel.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
				_channel = null;
				_time = 0;
				dispatchEvent(new Event(Event.SOUND_COMPLETE));
			}
		}

		public function SoundItem(sound : Sound = null, isLoop : Boolean = false) {
			_sound = (sound == null ? new Sound() : sound);
			_isLoop = isLoop;
			_time = 0;
		}

		public function get channel() : SoundChannel {
			return _channel;
		}

		public function get url() : String {
			return _sound.url;
		}

		public function load(stream : URLRequest) : void {
			if (_channel != null) {
				stop();
			}
			_sound = new Sound();
			_sound.load(stream);
		}

		public function play(value : Number = -1) : void {
			if (_channel != null || _sound == null) {
				return;
			}
			volume = (value == -1 ? _volume : value);
			_channel = _sound.play(_time);
			if (_channel != null) {
				_channel.addEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			}
		}

		public function pause() : void {
			if (_channel == null) {
				return;
			}
			_channel.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			_channel.stop();
			_time = _channel.position;
			_channel = null;
		}

		public function stop() : void {
			if (_channel == null) {
				return;
			}
			_channel.removeEventListener(Event.SOUND_COMPLETE, soundCompleteHandler);
			_channel.stop();
			_channel = null;
			if (_sound.url != null) {
				_sound.close();
			}
			_sound = null;
			_time = 0;
		}

		public function set volume(value : Number) : void {
			if (_channel == null) return;
			_volume = value;
			var transform : SoundTransform = _channel.soundTransform;
			transform.volume = _volume;
			_channel.soundTransform = transform;
		}

		public function get volume() : Number {
			return _volume;
		}

		public function get soundName() : String {
			return _soundName;
		}

		public function set soundName(value : String) : void {
			_soundName = value;
		}
	}
}
