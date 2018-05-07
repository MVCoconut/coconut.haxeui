package coconut.haxeui.macros;

import coconut.ui.macros.Generator;

class Setup {
  static function all() 
    coconut.ui.macros.HXX.generator = new Generator(
      tink.hxx.Generator.extractTags(macro coconut.haxeui.Node)
    );
  
}
