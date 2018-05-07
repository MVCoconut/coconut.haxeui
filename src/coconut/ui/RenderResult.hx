package coconut.ui;

import coconut.haxeui.*;

abstract RenderResult(Node) from Node to Node {
  @:from static function ofView(v:View):RenderResult 
    return Node.ofView(v);
}