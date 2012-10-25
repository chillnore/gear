package gear.ui.model {
	import gear.ui.drag.IDragItem;
	import gear.utils.GArrayUtil;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * List Model
	 * 
	 * @author bright
	 * @version 20110925
	 */
	public class ListModel extends EventDispatcher {
		private var _allowNull : Boolean;
		private var _fireEvent : Boolean;
		private var _limit : int;
		private var _max : int;
		private var _place : int;
		private var _source : Array;
		private var _oldSource : Array;
		private var _sortFun : Function;

		public function ListModel(allowNull : Boolean = false, limit : int = 0, max : int = 0, place : int = -1) {
			_allowNull = allowNull;
			_limit = limit;
			_max = max;
			_place = place;
			_fireEvent = true;
			_source = new Array();
		}

		public function set allowNull(value : Boolean) : void {
			_allowNull = value;
		}

		public function get allowNull() : Boolean {
			return _allowNull;
		}

		public function set fireEvent(value : Boolean) : void {
			_fireEvent = value;
		}

		public function set limit(value : int) : void {
			value = Math.max(0, Math.min(_max, value));
			if (_limit == value) return;
			_limit = value;
			if (_limit > 0 && _source.length > _limit) {
				_source.splice(_limit);
			}
			update();
		}

		public function get limit() : int {
			return _limit;
		}

		public function set max(value : int) : void {
			if (_max == value) return;
			_max = value;
			if (_max > 0 && _source.length > _max) {
				_source.splice(_max);
			}
			dispatchEvent(new Event(Event.RESIZE));
		}

		public function get max() : int {
			return _max;
		}

		public function set place(value : int) : void {
			_place = value;
			for (var i : int = 0; i < _source.length; i++) {
				if (_source[i]) _source[i].place = value;
			}
		}

		public function get place() : int {
			return _place;
		}

		public function set source(value : Array) : void {
			_oldSource = _source.concat();
			if (value == null) {
				if (_source.length > 0) {
					_source.length = 0;
				}
			} else {
				_source = value;
				if (_allowNull) {
					var end : int = (_limit == 0 ? _source.length : _limit);
					for (var i : int = 0;i < end;i++) {
						var item : IDragItem = _source[i] as IDragItem;
						if (item != null) {
							item.place = _place;
							item.grid = i;
						}
					}
				} else {
					GArrayUtil.trim(_source);
				}
			}
			dispatchEvent(new Event(Event.RESIZE));
			if (_fireEvent) {
				dispatchEvent(new GListEvent(GListEvent.CHANGE, ListState.RESET));
			}
		}

		public function get source() : Array {
			return _source;
		}

		public function get oldSource() : Array {
			return _oldSource;
		}

		public function set sortFun(value : Function) : void {
			_sortFun = value;
		}

		public function sort() : void {
			if (_sortFun != null) {
				_source.sort(_sortFun);
				if (_fireEvent) {
					dispatchEvent(new GListEvent(GListEvent.CHANGE, ListState.RESET));
				}
			}
		}

		public function clear() : void {
			_oldSource = _source.concat();
			_source.length = 0;
			if (_fireEvent) {
				dispatchEvent(new GListEvent(GListEvent.CHANGE, ListState.RESET));
			}
		}

		public function add(item : Object) : void {
			if (item == null) {
				return;
			}
			var index : int;
			if (_allowNull) {
				index = findFree();
				if (index == -1) {
					return;
				}
				setAt(index, item);
			} else {
				if (_max > 0 && _source.length >= _max) {
					return;
				}
				index = _source.push(item) - 1;
				dispatchEvent(new Event(Event.RESIZE));
				if (_fireEvent) {
					dispatchEvent(new GListEvent(GListEvent.CHANGE, ListState.ADDED, index, -1, item));
				}
			}
		}

		public function insert(index : int, item : Object) : void {
			if (index < 0 || index > size)
				return;
			if (_allowNull) {
				setAt(index, item);
			} else {
				if (_max > 0 && size >= _max) {
					return;
				}
				_source.splice(index, 0, item);
				dispatchEvent(new Event(Event.RESIZE));
				if (_fireEvent) {
					dispatchEvent(new GListEvent(GListEvent.CHANGE, ListState.INSERT, index, -1, item));
				}
			}
		}

		public function remove(item : Object) : void {
			var index : int = _source.indexOf(item);
			if (index != -1) {
				removeAt(index);
			}
		}

		public function removeAt(index : int) : void {
			if (index < 0 || index >= size) {
				return;
			}
			if (_allowNull) {
				setAt(index, null);
			} else {
				var item : Object = _source.splice(index, 1)[0];
				dispatchEvent(new Event(Event.RESIZE));
				if (_fireEvent) {
					dispatchEvent(new GListEvent(GListEvent.CHANGE, ListState.REMOVED, index, -1, null, item));
				}
			}
		}

		public function setAt(index : int, item : Object) : void {
			if (_limit > 0 && index >= _limit) {
				return;
			}
			var oldItem : Object;
			if (_allowNull) {
				if (_source[index] == item) {
					return;
				}
				oldItem = _source[index];
				_source[index] = item;
				if (item is IDragItem) {
					IDragItem(item).place = _place;
					IDragItem(item).grid = index;
				}
				if (_fireEvent) {
					dispatchEvent(new GListEvent(GListEvent.CHANGE, ListState.UPDATE, index, -1, item, oldItem));
				}
			} else {
				if (index < 0 || index > _source.length) {
					return;
				}
				if (_source[index] == item) {
					return;
				}
				oldItem = _source[index];
				if (item != null) {
					_source[index] = item;
					if (_fireEvent) {
						dispatchEvent(new GListEvent(GListEvent.CHANGE, oldItem == null ? ListState.ADDED : ListState.UPDATE, index, 1, item, oldItem));
					}
				} else {
					removeAt(index);
				}
			}
		}

		public function setList(index : int, list : Array) : void {
			for (var i : int = 0;i < list.length;i++) {
				_source[index + i] = list[i];
			}
			if (_fireEvent) {
				dispatchEvent(new GListEvent(GListEvent.CHANGE, ListState.RESET, index, list.length));
			}
		}

		public function clearList(index : int, length : int) : void {
			for (var i : int = 0;i < length;i++) {
				_source[index + i] = null;
			}
			if (_fireEvent) {
				dispatchEvent(new GListEvent(GListEvent.CHANGE, ListState.RESET, index, length));
			}
		}

		public function getAt(index : uint) : Object {
			return _source[index];
		}

		public function getLast() : Object {
			return _source[size - 1];
		}

		public function indexOf(value : Object) : int {
			return _source.indexOf(value);
		}

		public function findAt(key : String, value : Object) : int {
			for (var index : int = 0;index < _source.length;index++) {
				var item : Object = _source[index];
				if (item != null && item.hasOwnProperty(key) && item[key] == value) {
					return index;
				}
			}
			return -1;
		}

		public function findFree() : int {
			if (_allowNull) {
				for (var index : int = 0;index < _source.length;index++) {
					if (_source[index] == null) {
						break;
					}
				}
				if (_max > 0 && index >= _max) {
					return -1;
				}
				return index;
			} else {
				if (_max > 0) {
					if (_source.length < _max) {
						return _source.length;
					} else {
						return -1;
					}
				} else {
					return _source.length;
				}
			}
		}

		public function update(index : int = -1) : void {
			if (index != -1) {
				if (isValid(index)) {
					if (_fireEvent) {
						dispatchEvent(new GListEvent(GListEvent.CHANGE, ListState.UPDATE, index, -1, getAt(index), getAt(index)));
					}
				}
			} else {
				if (_fireEvent) {
					dispatchEvent(new GListEvent(GListEvent.CHANGE, ListState.RESET));
				}
			}
		}

		public function isValid(index : int) : Boolean {
			if (index < 0)
				return false;
			if (_max > 0) {
				if (index >= max)
					return false;
			} else {
				if (index >= size)
					return false;
			}
			return true;
		}

		public function get size() : int {
			return _max > 0 ? _max : _source.length;
		}

		public function get validSize() : int {
			if (_allowNull) {
				var size : int = 0;
				for (var index : int = 0;index < _source.length;index++) {
					if (_source[index] != null) {
						size++;
					}
				}
				return size;
			} else {
				return _source.length;
			}
		}

		public function get freeSize() : int {
			if (_allowNull) {
				if (_max > 0) {
					return _max - validSize;
				} else {
					return 0;
				}
			} else {
				return 0;
			}
		}

		public function toArray() : Array {
			return _source.concat();
		}

		public function toTrimArray() : Array {
			if (_allowNull) {
				var list : Array = new Array();
				for (var index : int = 0;index < _source.length;index++) {
					if (_source[index] != null) {
						list.push(_source[index]);
					}
				}
				return list;
			} else {
				return _source.concat();
			}
		}

		public function clone() : ListModel {
			var result : ListModel = new ListModel(_allowNull, _max, _place);
			result.source = _source.concat();
			return result;
		}
	}
}
