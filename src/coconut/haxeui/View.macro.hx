package coconut.haxeui;

class View {
  static function hxx(_, e)
    return coconut.haxeui.macros.HXX.parse(e);

  static function autoBuild()
    return
      coconut.diffing.macros.ViewBuilder.autoBuild(macro : coconut.haxeui.RenderResult);
}