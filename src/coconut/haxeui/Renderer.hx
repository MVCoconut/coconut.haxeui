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

private class HaxeUiCursor extends Cursor<Component> {

  var pos:Int;
  final container:Component;

  public function new(applicator, container:Component, pos:Int) {
    super(applicator);
    this.container = container;
    this.pos = pos;
  }

  public function insert(real:Component) {
    var inserted = real.parentComponent != container;

    if (inserted) {
      container.addComponentAt(real, pos);
      if (real.customStyle != null)
        @:privateAccess real.applyStyle(real.customStyle);
    }
    else if (container.getComponentAt(pos) != real)
      container.setComponentIndex(real, pos);
    pos++;
  }

  public function delete(count:Int)
    if (count == 0) return
    else if (pos == 0 && count == container.numComponents)
      container.removeAllComponents();
    else
      while (count --> 0)
        container.removeComponentAt(pos, true, count == 0);// only the last removal needs to trigger invalidation
}

private class HaxeUiBackend implements Applicator<Component> {
  public function new() {}

  public function siblings(target:Component):Cursor<Component>
    return new HaxeUiCursor(this, target.parentComponent, target.parentComponent.getComponentIndex(target));

  public function children(target:Component):Cursor<Component>
    return new HaxeUiCursor(this, target, 0);

  static final POOL = [];
  public function createMarker()
    return switch POOL.pop() {
      case null: new Component();
      case v: v;
    }

  public function releaseMarker(c:Component)
    POOL.push(c);
}

class HaxeUiNodeType<Attr:{}, Real:Component> extends Factory<Attr, Component, Real> {

  static var events = coconut.haxeui.macros.Setup.getEvents();

  final factory:Void->Real;

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