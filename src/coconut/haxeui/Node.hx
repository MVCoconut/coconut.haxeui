package coconut.haxeui;

@:build(coconut.haxeui.macros.Nodes.build())
@:pure class Node {
  
  public var type(default, null):NodeType;
  public var attributes(default, null):{};
  public var children(default, null):coconut.ui.Children;
  public var view(default, null):coconut.ui.View;

  function new() {}

  static function make(type, attributes, ?children) {
    var ret = new Node();
    ret.type = type;
    ret.attributes = attributes;
    ret.children = children;
    return ret;
  }
  
  static inline function ofView(v:coconut.ui.View) {
    var ret = new Node();
    ret.view = v;
    return ret;
  }
}

typedef NodeType = Class<haxe.ui.core.Component>;