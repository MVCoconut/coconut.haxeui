package coconut.haxeui;

#if !macro
import haxe.ui.core.Component;
import haxe.ui.diff.Diff.*;
import haxe.ui.diff.*;
import tink.state.*;

using tink.CoreApi;

class Renderable implements Widget {
  
  @:noCompletion var __rendered:Observable<Node>;
  @:noCompletion var __component:Component;
  @:noCompletion var __binding:CallbackLink;
  @:noCompletion var __lastRender:Node;
  
  static var keygen = 0;
  @:noCompletion @:keep var key:String;
  
  public function new(rendered, ?key:String) {
    this.__rendered = rendered;
    // if (key == null)
    //   key = __rendered;
      
    // this.key = key;
  }
        
  @:noCompletion public function initComponent():Component {
    __lastRender = __rendered;
    this.beforeInit();
    this.__component = new Component();
    __component.addComponent(createElement(__lastRender));
    this.afterInit(__component);
    __setupBinding();
    
    return this.__component;
  }
  
  @:noCompletion function __setupBinding()
    this.__binding = this.__rendered.bind(function (next) {
      if (next != __lastRender) __apply(next);
    });
  
  @:noCompletion function __apply(next) {
    beforePatching(this.__component);
    updateElement(__component, next, __lastRender);
    __lastRender = next;
    afterPatching(this.__component);
  }
    
  public function toComponent() 
    return switch __component {
      case null: initComponent();
      case v: v;
    } 

  @:noCompletion function beforeInit() {}
  @:noCompletion function afterInit(element:Component) {}
  @:noCompletion function beforePatching(element:Component) {}
  @:noCompletion function afterPatching(element:Component) {}
  @:noCompletion function beforeDestroy(element:Component) {}
  @:noCompletion function afterDestroy(element:Component) {}
  
  @:noCompletion public function update(x:{}, y):Component {
    switch Std.instance(x, Renderable) {
      case null:
      case v: __reuseRender(v);
    }
    return toComponent();
  }

  @:noCompletion private function __reuseRender(that:Renderable) {
    this.__component = that.__component;
    this.__lastRender = that.__lastRender;
    __apply(__rendered);
    __setupBinding();
    that.destroy();
  }
  
  macro function get(_, e);
  macro function hxx(e);

  @:noCompletion public function destroy():Void {
    beforeDestroy(this.__component);
    this.__binding.dissolve();
    // super.destroy();
    
    // function _destroy(v:VNode) {
    //   switch ((cast v).children:Array<Dynamic>) {
    //     case null:
    //     case children:
    //       for(child in children) {
    //         switch Std.instance(child, Widget) {
    //           case null:
    //           case v: v.destroy();
    //         }
    //         _destroy(child);
    //       }
    //   }
    // }
    // _destroy(__lastRender);
    afterDestroy(this.__component);
  }  
}

#else
class Renderable {
 
  macro function get(_, e) 
    return coconut.vdom.macros.Select.typed(e);
  macro function hxx(_, e) 
    return 
      #if coconut_ui
        coconut.ui.macros.HXX.parse(e);
      #else
        vdom.VDom.hxx(e);
      #end
}
#end