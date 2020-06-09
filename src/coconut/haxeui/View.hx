package coconut.haxeui;

@:build(coconut.ui.macros.ViewBuilder.build((_:coconut.haxeui.RenderResult)))
@:autoBuild(coconut.haxeui.View.autoBuild())
class View extends coconut.diffing.Widget<haxe.ui.core.Component> {
  macro function hxx(e);
}