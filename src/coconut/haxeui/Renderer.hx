package coconut.haxeui;

import coconut.diffing.Factory;
import coconut.diffing.*;
import haxe.ui.core.*;

class Renderer {

  static final BACKEND = new HaxeUiBackend();

  static public function mountInto(target:Component, virtual:RenderResult)
    Root.fromNative(target, BACKEND).render(virtual);

  static public function getNative(view:View):Null<Component>
    return getAllNative(view)[0];

  static public function getAllNative(view:View):Array<Component>
    return Widget.getAllNative(view);

  static public inline function updateAll()
    tink.state.Observable.updateAll();

  static public macro function hxx(e);

  static public macro function mount(target, markup);
}

private class HaxeUiCursor implements Cursor<Component> {

  var pos:Int;
  final container:Component;
  public final applicator:Applicator<Component>;

  public function new(applicator, container:Component, pos:Int) {
    this.applicator = applicator;
    this.container = container;
    this.pos = pos;
  }

  public function insert(real:Component) {
    var inserted = real.parentComponent != container;
    if (inserted)
      container.addComponentAt(real, pos);
    else if (container.getComponentAt(pos) != real)
      container.setComponentIndex(real, pos);
    pos++;
  }

  public function delete(count) {

  }
  //   return
  //     if (pos <= container.childComponents.length) {
  //       container.removeComponent(current());
  //       true;
  //     }
  //     else false;

  // public function step():Bool
  //   return
  //     if (pos >= container.childComponents.length) false;
  //     else ++pos == container.childComponents.length;

  // public function current():Component
  //   return container.getComponentAt(pos);
}

private class HaxeUiBackend implements Applicator<Component> {
  public function new() {}

  public function siblings(target:Component):Cursor<Component>
    return new HaxeUiCursor(this, target.parentComponent, target.parentComponent.getComponentIndex(target));

  public function children(target:Component):Cursor<Component>
    return new HaxeUiCursor(this, cast target, 0);

  static final POOL = [];
  public function createMarker()
    return switch POOL.pop() {
      case null: new Component();
      case v: v;
    }

  public function releaseMarker(c:Component)
    POOL.push(c);
}

class HaxeUiNodeType<Attr:{}, Real:Component> implements Factory<Attr, Component, Real> {

  static var events = coconut.haxeui.macros.Setup.getEvents();

  var factory:Void->Real;

  public final type = new TypeId();

  public function new(factory)
    this.factory = factory;

  inline function set(target:Real, prop:String, val:Dynamic, old:Dynamic)
    switch events[prop] {
      case null: Reflect.setProperty(target, prop, val);
      case event:
        if (old != null) target.unregisterEvent(event, old);
        if (val != null) target.registerEvent(event, val);
    }

  public function create(a:Attr):Real {
    var ret = factory();
    update(ret, a, null);
    return ret;
  }

  public function update(r:Real, nu:Attr, old:Attr):Void
    Properties.set(r, nu, old, set);
}