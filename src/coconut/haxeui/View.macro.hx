package coconut.haxeui;

class View {
  static function hxx(_, e)
    return coconut.haxeui.macros.HXX.parse(e);

  static function init()
    return
      coconut.diffing.macros.ViewBuilder.init(macro : coconut.haxeui.RenderResult);
}