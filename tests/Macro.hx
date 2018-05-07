import haxe.macro.Expr;

using haxe.macro.Tools;

class Macro {
  static function check() {
    haxe.macro.Context.onGenerate(function (_) {
      switch haxe.macro.Context.getType('haxe.ui.components.CheckBox') {
        case TInst(_.get() => cl, _):
          // for (cl.meta.get());
          // trace(cl.meta.extract(':keep')[0].pos);
          // trace(TAnonymous([{
          //   name: '_',
          //   kind: FVar(macro : X),
          //   pos: cl.pos,
          //   meta: cl.meta.get(),
          // }]).toString());
        default: throw 'assert';
      }
    });
  }
}