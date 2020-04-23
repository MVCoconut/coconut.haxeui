package coconut.haxeui;

class Renderer {
  static public function hxx(e)
    return coconut.haxeui.macros.HXX.parse(e);

  static function mount(target, markup)
    return coconut.ui.macros.Helpers.mount(macro coconut.haxeui.Renderer.mountInto, target, markup, hxx);
}