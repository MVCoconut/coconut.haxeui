package coconut.haxeui.macros;

#if macro
import haxe.macro.Type;
import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.Tools;
using tink.MacroApi;
using sys.FileSystem;
using haxe.io.Path;

class Setup {
  static function all() {
    var cl = Context.getType('haxe.ui.core.Component').getClass();    
    cl.meta.add(':autoBuild', [macro @:pos(cl.pos) coconut.haxeui.macros.Setup.hxxAugment()], cl.pos);
  }

  static function getEvents() {
    return [for (f in Context.getType('coconut.haxeui.Events').getFields().sure()) macro $v{f.name} => ${f.meta.extract(':type')[0].params[0]}].toArray();
  }

  static function hxxAugment() {
    var fields = Context.getBuildFields(),
        cl = Context.getLocalClass().get();
    
    var attributes = {
      var ret:Array<Field> = [];

      function crawl(target:ClassType) {
        for (f in target.fields.get())
          switch f.kind {
            case FVar(AccCall, AccCall):
              ret.push({
                name: f.name,
                pos: f.pos,
                kind: FProp('default', 'never', f.type.toComplex()),
                meta: [{ name: ':optional', params: [], pos: f.pos }],
              });
            default:
          }
        if (target.superClass != null)
          crawl(target.superClass.t.get());//TODO: do something about params
      }
      
      crawl(cl);

      TExtend(['coconut.haxeui.Events'.asTypePath()], ret);
    }

    var self = Context.getLocalType().toComplex();//TODO: type params

    return fields.concat((
      macro class {
        static var COCONUT_NODE_TYPE = new coconut.ui.Renderer.HaxeUiNodeType<$attributes, haxe.ui.core.Component>($i{cl.name}.new);
        static public inline function fromHxx(
          hxxMeta:{ 
            @:optional var key(default, never):coconut.diffing.Key;
            @:optional var ref(default, never):coconut.ui.Ref<$self>;
          },
          attr:$attributes, 
          ?children:coconut.ui.Children):coconut.ui.RenderResult
        {
          return coconut.diffing.VNode.native(COCONUT_NODE_TYPE, cast hxxMeta.ref, hxxMeta.key, attr, children);
        }
      }
    ).fields);
  }
}
#else
class Setup {
  macro static public function getEvents();
}
#end