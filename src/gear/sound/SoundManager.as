package gear.sound {
	import gear.log4a.LogError;
	import gear.log4a.GLogger;
	import gear.net.AssetData;
	import gear.net.RESManager;

	import flash.events.Event;
	import flash.media.Sound;

	/**
	 * Sound Manager
	 * 
	 * @author bright
	 * @version 20100124
	 */
	public class SoundManager {
		private static var _creating : Boolean = false;
		private static var _instance : SoundManager;
		private var _music : SoundItem;
		private var _soundList : Array;
		private var _musicIsOpen : Boolean;
		private var _soundIsOpen : Boolean;
		private var _musicVolume : Number;
		private var _soundVolume : Number;

		private function init() : void {
			_musicIsOpen = false;
			_musicVolume = 0.5;
			_soundIsOpen = true;
			_soundVolume = 0.8;
			_soundList = new Array();
		}

		private function sound_completeHandler(event : Event) : void {
			var soundItem : SoundItem = SoundItem(event.target);
			soundItem.removeEventListener(Event.SOUND_COMPLETE, sound_completeHandler);
			var index : int = _soundList.indexOf(soundItem);
			if (index != -1) {
				_soundList.splice(index, 1);
			}
		}

		public function SoundManager() {
			if (!_creating) {
				throw (new LogError("Class cannot be instantiated.Use RESManager.instance instead."));
			}
			init();
		}

		public static function get instance() : SoundManager {
			if (_instance == null) {
				_creating = true;
				_instance = new SoundManager();
				_creating = false;
			}
			return _instance;
		}

		public function playMusic(key : String, libKey : String) : void {
			if (!_musicIsOpen) {
				return;
			}
			if (_music != null) {
				_music.stop();
			}
			var sound : Sound = RESManager.getSound(new AssetData(key, libKey));
			if (sound == null) {
				GLogger.error("music not found:", key);
				return;
			}
			_music = new SoundItem(sound, true);
			_music.soundName = key;
			_music.play(_musicVolume);
		}

		public function get music() : SoundItem {
			return _music;
		}

		public function playSound(key : String, libKey : String, loop : Boolean = false) : void {
			if (!_soundIsOpen) {
				return;
			}
			var sound : Sound = RESManager.getSound(new AssetData(key, libKey));
			if (sound == null) {
				GLogger.error("sound not found:", key);
				return;
			}
			var item : SoundItem = new SoundItem(sound, loop);
			item.play(_soundVolume);
			item.soundName = key;
			item.addEventListener(Event.SOUND_COMPLETE, sound_completeHandler);
			_soundList.push(item);
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