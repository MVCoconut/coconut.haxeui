package coconut.haxeui;

typedef NodeType = Class<haxe.ui.core.Component>;

@:pure class Node {
  
  public var type(default, null):NodeType;
  public var attributes(default, null):{};
  public var children(default, null):coconut.ui.Children;
  public var view(default, null):coconut.ui.View;

  function new() {}

  static public function make(type, attributes, ?children) {
    var ret = new Node();
    ret.type = type;
    ret.attributes = attributes;
    ret.children = children;
    return ret;
  }
  static public inline function ofView(v:coconut.ui.View) {
    var ret = new Node();
    ret.view = v;
    return ret;
  }
}