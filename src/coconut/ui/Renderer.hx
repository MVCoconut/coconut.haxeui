package coconut.ui;

import coconut.diffing.*;
import haxe.ui.core.*;

class Renderer {
  
  static var DIFFER = new coconut.diffing.Differ(new HaxeUiBackend());

  static public function mount(target:Component, virtual:RenderResult)
    DIFFER.render([virtual], target);

  static public function getNative(view:View):Null<Component>
    return getAllNative(view)[0];

  static public function getAllNative(view:View):Array<Component>
    return switch @:privateAccess view._coco_lastRender {
      case null: [];
      case r: r.flatten(null);
    }

  static public inline function updateAll()
    tink.state.Observable.updateAll();
}

private class HaxeUiCursor implements Cursor<Component> {
  
  var pos:Int;
  var container:Component;

  public function new(container:Component, pos:Int) {
    this.container = container;
    this.pos = pos;
  }

  public function insert(real:Component):Bool { 
    var inserted = real.parentComponent != container;
    container.addComponentAt(real, pos);
    return inserted;
  }

  public function delete():Bool
    return 
      if (pos <= container.childComponents.length) {
        container.removeComponent(container.childComponents[pos]);
        true;
      }
      else false;

  public function step():Bool 
    return
      if (pos >= container.childComponents.length) false;
      else ++pos == container.childComponents.length;

  public function current():Component 
    return container.getComponentAt(pos);
}

private class HaxeUiBackend implements Applicator<Component> {
  public function new() {}
  var registry:Map<Component, Rendered<Component>> = new Map();
  
  public function unsetLastRender(target:Component):Rendered<Component> {
    var ret = registry[target];
    registry.remove(target);
    return ret;
  }

  public function setLastRender(target:Component, r:Rendered<Component>):Void 
    registry[target] = r;

  public function getLastRender(target:Component):Null<Rendered<Component>> 
    return registry[target];

  public function traverseSiblings(target:Component):Cursor<Component> 
    return new HaxeUiCursor(target.parentComponent, target.parentComponent.getComponentIndex(target));

  public function traverseChildren(target:Component):Cursor<Component> 
    return new HaxeUiCursor(cast target, 0);

  public function placeholder(forTarget:Widget<Component>):VNode<Component>
    return VNode.native(PLACEHOLDER, null, null, null, null); 

  static final PLACEHOLDER = new HaxeUiNodeType(Component.new);
}

class HaxeUiNodeType<Attr:{}, Real:Component> implements NodeType<Attr, Real> {
  
  var factory:Void->Real;

  public function new(factory) 
    this.factory = factory;

  function setListener(target, prop, val, old) 
    if (old != val) {
      if (old != null) target.removeEventListener(prop, old);
      if (val != null) target.addEventListener(prop, val);
    }

  inline function set(target, prop, val, old)
    switch prop {
      // case 'on': Differ.updateObject(target, val, old, setListener);
      default: Reflect.setProperty(target, prop, val);
    }

  public function create(a:Attr):Real {
    var ret = factory();
    Differ.updateObject(ret, a, null, set);
    return ret;
  }

  public function update(r:Real, old:Attr, nu:Attr):Void 
    Differ.updateObject(r, nu, old, set);
}