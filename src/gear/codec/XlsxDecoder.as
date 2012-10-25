package gear.codec {
	import gear.data.HashMap;
	import gear.net.WorkSheet;

	import flash.utils.ByteArray;

	/**
	 * xlsx文件解码
	 * 
	 * @author bright
	 * @version 20121025
	 */
	public class XlsxDecoder {
		private var _zipDecoder : ZipDecoder;
		private var _list : HashMap;
		private var _shared : Array;
		private var _xlsxFile : ByteArray;

		private function getSharedString() : void {
			_shared = new Array();
			var url : String = "xl/sharedStrings.xml";
			var ba : ByteArray = _zipDecoder.getFile(url);
			ba.position = 0;
			var xmlString : String = ba.readUTFBytes(ba.bytesAvailable);
			var xml : XML = new XML(xmlString);
			var ns : Namespace = xml.namespace();
			var valueList : XMLList = xml.ns::si;
			for each (var valueListItem:XML in valueList) {
				var textList : XMLList = valueListItem..ns::t;
				var value : String = "";
				for each (var textListItem:XML in textList) {
					value += textListItem[0];
				}
				_shared.push(value);
			}
		}

		private function getColIndex(colName : String) : int {
			var abc : String = colName.replace(/(\d)/g, "");
			return textToInt(abc);
		}

		private function colNameToPosition(colName : String) : Array {
			var colText : String = colName.replace(/(\d)/g, "");
			var col : int = textToInt(colText);
			var row : int = int(colName.replace(colText, "")) - 1;
			return [row, col];
		}

		private function textToInt(abc : String) : int {
			var returnValue : int = 0;
			for (var i : int = abc.length - 1;i >= 0;i--) {
				var cValue : int = abc.charCodeAt(i) - 65;
				returnValue = returnValue + cValue + (i * 26);
			}
			return returnValue;
		}

		private function parseSheet(ws : WorkSheet) : void {
			var sheetUrl : String = "xl/worksheets/sheet" + ws.index + ".xml";
			var byteArray : ByteArray = _zipDecoder.getFile(sheetUrl);
			var xmlString : String = byteArray.readUTFBytes(byteArray.bytesAvailable);
			var xml : XML = new XML(xmlString);
			var ns : Namespace = xml.namespace();
			var excelArray : Array = [];
			var rowList : XMLList = xml.ns::sheetData.ns::row;
			for each (var rowListItem:XML in rowList) {
				var rowIndex : int = int(rowListItem.@r) - 1;
				var rowArray : Array = [];
				var colList : XMLList = rowListItem.ns::c;
				for each (var colListItem:XML in colList) {
					var colIndex : int = getColIndex(colListItem.@r);
					var t : String = colListItem.@t;
					var v : String = colListItem.ns::v[0];
					if (t == "s") {
						rowArray[colIndex] = _shared[int(v)];
					} else {
						rowArray[colIndex] = v;
					}
				}
				excelArray[rowIndex] = rowArray;
			}
			var mergeCellList : XMLList = xml.ns::mergeCells.ns::mergeCell;
			for each (var mergeCellXML:XML in mergeCellList) {
				var ref : String = mergeCellXML.@ref;
				var refArr : Array = ref.split(":");
				var sArr : Array = colNameToPosition(refArr[0]);
				var eArr : Array = colNameToPosition(refArr[1]);
				var sValue : Object;
				if (excelArray[sArr[0]] != null) {
					sValue = excelArray[sArr[0]][sArr[1]];
				}
				for (var i : int = sArr[0];i <= eArr[0];i++) {
					for (var j : int = sArr[1];j <= eArr[1];j++) {
						if (excelArray[i] == null) {
							excelArray[i] = [];
						}
						excelArray[i][j] = sValue;
					}
				}
			}
			ws.list = excelArray;
		}

		private function parse() : void {
			if (_xlsxFile == null) {
				return;
			}
			_zipDecoder.addZipFile(_xlsxFile);
			getSharedString();
			var byteArray : ByteArray = _zipDecoder.getFile("xl/workbook.xml");
			var xml : XML = new XML(byteArray.readUTFBytes(byteArray.bytesAvailable));
			var ns : Namespace = xml.namespace();
			var ws : WorkSheet;
			_list = new HashMap();
			var index : int = 1;
			for each (var sheet:XML in xml.ns::sheets.*) {
				ws = new WorkSheet();
				ws.name = sheet.@name;
				ws.index = index++;
				parseSheet(ws);
				_list.put(ws.name, ws);
			}
		}

		public function XlsxDecoder(xlsxFile : ByteArray = null) {
			_zipDecoder = new ZipDecoder();
			_xlsxFile = xlsxFile;
			parse();
		}

		public function set xlsxFile(value : ByteArray) : void {
			_xlsxFile = value;
			parse();
		}

		public function getSheet(name : String) : WorkSheet {
			if (_list != null) {
				return _list.getBy(name);
			}
			return _list.getBy(name);
		}
	}
}
