package coconut.haxeui.macros;

#if macro
import haxe.macro.Type;
import haxe.macro.Context;
import haxe.macro.Expr;
using haxe.macro.Tools;
using tink.MacroApi;

class Setup {
  static function all() {
    var cl = Context.getType('haxe.ui.core.Component').getClass();
    
    cl.meta.add(':autoBuild', [macro @:pos(cl.pos) coconut.haxeui.macros.Setup.hxxAugment()], cl.pos);
  }

  static function hxxAugment() {

    var fields = Context.getBuildFields(),
        cl = Context.getLocalClass().get();

    var properties = {
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

      TAnonymous(ret);
    }

    return fields.concat((
      macro class {
        static public inline function fromHxx(props:$properties) {
          return null;
        }
      }
    ).fields);
  }
}
#end