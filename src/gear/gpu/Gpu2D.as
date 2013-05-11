package gear.gpu {
	import flash.display3D.Program3D;
	import gear.gui.skins.GTreeIcon;

	import com.adobe.utils.AGALMiniAssembler;

	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.textures.Texture;
	import flash.events.Event;

	/**
	 * @author Administrator
	 */
	public class Gpu2D {
		protected var _width : int;
		protected var _height : int;
		protected var _stage3D : Stage3D;
		protected var _context3D : Context3D;

		private function context3DCreateHandler(event : Event) : void {
			_context3D = _stage3D.context3D;
			// 顶点数据
			var vb : Vector.<Number> = Vector.<Number>([0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0]);
			var vbs : VertexBuffer3D = _context3D.createVertexBuffer(vb.length / 4, 4);
			vbs.uploadFromVector(vb, 0, vb.length / 4);
			// 顶点索引
			var ib : Vector.<uint> = Vector.<uint>([0, 3, 1, 1, 2, 3]);
			var ibs : IndexBuffer3D = _context3D.createIndexBuffer(ib.length);
			ibs.uploadFromVector(ib, 0, ib.length);
			// 纹理
			var tex : Texture = _context3D.createTexture(128, 128, Context3DTextureFormat.BGRA, true);
			var bd : BitmapData = new BitmapData(128, 128, false, 0xFF0000);
			bd.draw(GTreeIcon.closeIcon);
			tex.uploadFromBitmapData(bd, 0);
			// AGAL
			var vp : String = "mov op, va0 \n mov v0, va1";
			var vagal : AGALMiniAssembler = new AGALMiniAssembler();
			vagal.assemble(Context3DProgramType.VERTEX, vp);
			var fp : String = "tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n mov oc,ft0";
			var fagal : AGALMiniAssembler = new AGALMiniAssembler();
			fagal.assemble(Context3DProgramType.FRAGMENT, fp);
			// shader
			var pm:Program3D = this._context3D.createProgram();
			pm.upload(vagal.agalcode, fagal.agalcode);
			_context3D.setTextureAt(0, tex);
			_context3D.setProgram(pm);
			_context3D.setVertexBufferAt(0, vbs, 0, Context3DVertexBufferFormat.FLOAT_2);
			_context3D.setVertexBufferAt(1, vbs, 2, Context3DVertexBufferFormat.FLOAT_2);
			_context3D.clear();
            _context3D.drawTriangles(ibs);
            _context3D.present();
		}

		public function Gpu2D(stage : Stage) {
			_stage3D = stage.stage3Ds[0];
			_stage3D.addEventListener(Event.CONTEXT3D_CREATE, context3DCreateHandler);
			_stage3D.requestContext3D();
		}
	}
}
