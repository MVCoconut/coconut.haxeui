package coconut.ui;

import haxe.ui.diff.Node;
import haxe.ui.diff.*;

abstract RenderResult(Node) from Node to Node {
  @:from static function ofWidget(w:Widget):RenderResult 
    return Widget(w);
}