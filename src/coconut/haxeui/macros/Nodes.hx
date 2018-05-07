package coconut.haxeui.macros;

import haxe.macro.Context.*;
import haxe.macro.Expr;

using haxe.macro.Tools;
using sys.FileSystem;
using tink.MacroApi;
using haxe.io.Path;

class Nodes {
  static function build() {
    
    var ret = getBuildFields(),
        path = getPosInfos(getType('haxe.ui.core.Component').getClass().pos).file.directory().directory();

    for (dir in ['components', 'containers']) 
      for (entry in '$path/$dir'.readDirectory()) 

        switch new Path(entry) {
          case { ext: 'hx', file: name }:
            
            var fqn = 'haxe.ui.$dir.$name';

            var t = getType(fqn),
                args = [],
                callArgs = [fqn.resolve()];
            
            var cl = t.getClass();
            var call = macro @:pos(cl.pos) return coconut.haxeui.Node.make($a{callArgs});

            ret.push({
              pos: cl.pos,
              name: name,
              access: [APublic, AStatic, AInline],
              kind: FFun({
                args: args,
                ret: null,
                expr: call,
              }),
            });
            
            function add(arg) {
              args.push(arg);
              callArgs.push(macro $i{arg.name});
            }

            add({
              name: 'attributes',
              type: TAnonymous([for (f in t.getFields().sure()) switch f.kind {
                case FVar(_, _):
                  {
                    name: f.name,
                    pos: f.pos,
                    kind: FProp('default', 'never', f.type.toComplex()),
                    meta: [{ name: ':optional', params: [], pos: cl.pos }],
                  }
                default: continue;
              }])
            });

            if (dir == 'containers')
              add({
                name: 'children',
                opt: true,
                type: null,
              });

          default:
        }

    // trace(TAnonymous(ret).toString());

    return ret;
  }
}