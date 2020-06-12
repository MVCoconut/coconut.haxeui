package coconut.haxeui.macros;

#if macro
import haxe.macro.Type;
import haxe.macro.Expr;

using haxe.macro.Tools;
using tink.MacroApi;
#else
@:genericBuild(coconut.haxeui.macros.Attributes.build())
#end
class Attributes<T> {
  #if macro
  static function build() 
    return tink.macro.BuildCache.getType('coconut.haxeui.macros.Attributes', function (ctx) {
      var fields:Array<Field> = [];

      function crawl(target:ClassType) {
        for (f in target.fields.get()) {
          if(f.name == 'style') continue;
          if(f.name == 'customStyle' || f.kind.match(FVar(AccCall, AccCall))) {
            if(!f.meta.has(':keep')) f.meta.add(':keep', [], f.pos);
            var field;
            fields.push(field = {
              name: f.name,
              pos: f.pos,
              kind: FProp('default', 'never', f.type.toComplex()),
              meta: [{ name: ':optional', params: [], pos: f.pos }],
            });
            
            if(f.name == 'customStyle')
              field.meta.push({ name: ':hxx', params: [macro style], pos: f.pos });
          }
        }
        if (target.superClass != null)
          crawl(target.superClass.t.get());//TODO: do something about params
      }
        
      crawl(ctx.type.getClass());
      

      return {
        name: ctx.name,
        pack: [],
        pos: ctx.pos,
        fields: fields,
        kind: TDAlias(TExtend(['coconut.haxeui.Events'.asTypePath([TPType(ctx.type.toComplex())])], fields))
      }

    });
  #end
}