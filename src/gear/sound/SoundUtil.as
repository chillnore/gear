package gear.sound {
	import gear.log4a.GLogger;
	import gear.log4a.GLogError;
	import gear.net.GLoadUtil;

	import flash.events.Event;
	import flash.media.Sound;
	import flash.utils.Dictionary;

	/**
	 * Sound Manager
	 * 
	 * @author bright
	 * @version 20120506
	 */
	public class SoundUtil {
		private static var _creating : Boolean = false;
		private static var _instance : SoundUtil;
		private var _music : SoundItem;
		private var _soundList : Dictionary;
		private var _musicIsOpen : Boolean;
		private var _soundIsOpen : Boolean;
		private var _musicVolume : Number;
		private var _soundVolume : Number;

		private function init() : void {
			_musicIsOpen = false;
			_musicVolume = 0.5;
			_soundIsOpen = true;
			_soundVolume = 0.8;
			_soundList = new Dictionary();
		}

		private function sound_completeHandler(event : Event) : void {
			var soundItem : SoundItem = SoundItem(event.target);
			soundItem.removeEventListener(Event.SOUND_COMPLETE, sound_completeHandler);
			_soundList[soundItem.key] = null;
		}

		public function SoundUtil() {
			if (!_creating) {
				throw (new GLogError("Class cannot be instantiated.Use RESManager.instance instead."));
			}
			init();
		}

		public static function get instance() : SoundUtil {
			if (_instance == null) {
				_creating = true;
				_instance = new SoundUtil();
				_creating = false;
			}
			return _instance;
		}

		public function playMusic(key : String, lib : String) : void {
			if (!_musicIsOpen) {
				return;
			}
			if (_music != null) {
				_music.stop();
			}
			var sound : Sound = GLoadUtil.getSound(key, lib);
			if (sound == null) {
				GLogger.error("music not found:", key);
				return;
			}
			_music = new SoundItem(key, sound, true);
			_music.soundName = key;
			_music.play(_musicVolume);
		}

		public function get music() : SoundItem {
			return _music;
		}

		public function playSound(key : String, lib : String, loop : Boolean = false) : void {
			if (!_soundIsOpen) {
				return;
			}
			if (_soundList[key] != null) {
				return;
			}
			var sound : Sound = GLoadUtil.getSound(key, lib);
			if (sound == null) {
				return;
			}
			var item : SoundItem = new SoundItem(key, sound, loop);
			item.play(_soundVolume);
			item.soundName = key;
			item.addEventListener(Event.SOUND_COMPLETE, sound_completeHandler);
			_soundList[item.key] = item;
		}

		public function set musicIsOpen(value : Boolean) : void {
			_musicIsOpen = value;
			if (_music == null) {
				return;
			}
			if (_musicIsOpen) {
				_music.play();
			} else {
				_music.pause();
			}
		}

		public function get musicIsOpen() : Boolean {
			return _musicIsOpen;
		}

		public function set musicVolume(value : Number) : void {
			_musicVolume = value;
		}

		public function get musicVolume() : Number {
			return _musicVolume;
		}

		public function set soundIsOpen(value : Boolean) : void {
			_soundIsOpen = value;
			for each (var soundItem:SoundItem in _soundList) {
				if (value) {
					soundItem.play();
				} else {
					soundItem.stop();
				}
			}
		}

		public function get soundIsOpen() : Boolean {
			return _soundIsOpen;
		}

		public function set soundVolume(value : Number) : void {
			_soundVolume = value;
			for each (var soundItem:SoundItem in _soundList) {
				soundItem.volume = value;
			}
		}

		public function get soundVolume() : Number {
			return _soundVolume;
		}

		public function ifHadSound(key : String) : Boolean {
			for each (var soundItem:SoundItem in _soundList) {
				if (key == soundItem.soundName) {
					return true;
				}
			}
			return false;
		}

		public function delSound(key : String) : void {
			for (var i : int = 0;i < _soundList.length;i++) {
				if (key == _soundList[i].soundName) {
					_soundList[i].stop();
					_soundList.splice(i, 1);
					i--;
				}
			}
		}
	}
}