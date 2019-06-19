package coconut.haxeui;

import haxe.ui.events.*;

using tink.CoreApi;

typedef Events = {
  @:type("animationstart") @:optional var onAnimationStart(default, never):Callback<AnimationEvent>;
  @:type("animationend") @:optional var onAnimationEnd(default, never):Callback<AnimationEvent>;
  @:type("focusin") @:optional var onFocusIn(default, never):Callback<FocusEvent>;
  @:type("focusout") @:optional var onFocusOut(default, never):Callback<FocusEvent>;
  @:type("keydown") @:optional var onKeyDown(default, never):Callback<KeyboardEvent>;
  @:type("keyup") @:optional var onKeyUp(default, never):Callback<KeyboardEvent>;
  @:type("mousemove") @:optional var onMouseMove(default, never):Callback<MouseEvent>;
  @:type("mouseover") @:optional var onMouseOver(default, never):Callback<MouseEvent>;
  @:type("mouseout") @:optional var onMouseOut(default, never):Callback<MouseEvent>;
  @:type("mousedown") @:optional var onMouseDown(default, never):Callback<MouseEvent>;
  @:type("mouseup") @:optional var onMouseUp(default, never):Callback<MouseEvent>;
  @:type("mousewheel") @:optional var onMouseWheel(default, never):Callback<MouseEvent>;
  @:type("click") @:optional var onClick(default, never):Callback<MouseEvent>;
  @:type("rightclick") @:optional var onRightClick(default, never):Callback<MouseEvent>;
  @:type("rightmousedown") @:optional var onRightMouseDown(default, never):Callback<MouseEvent>;
  @:type("rightmouseup") @:optional var onRightMouseUp(default, never):Callback<MouseEvent>;
  @:type("scrollchange") @:optional var onScrollchange(default, never):Callback<ScrollEvent>;
  @:type("scrollstart") @:optional var onScrollStart(default, never):Callback<ScrollEvent>;
  @:type("scrollstop") @:optional var onScrollStop(default, never):Callback<ScrollEvent>;
  @:type("ready") @:optional var onReady(default, never):Callback<UIEvent>;
  @:type("resize") @:optional var onResize(default, never):Callback<UIEvent>;
  @:type("change") @:optional var onChange(default, never):Callback<UIEvent>;
  @:type("beforeChange") @:optional var onBeforeChange(default, never):Callback<UIEvent>;
  @:type("move") @:optional var onMove(default, never):Callback<UIEvent>;
  @:type("initialize") @:optional var onInitialize(default, never):Callback<UIEvent>;
  @:type("rendererCreated") @:optional var onRendererCreated(default, never):Callback<UIEvent>;
  @:type("rendererDestroyed") @:optional var onRendererDestroyed(default, never):Callback<UIEvent>;
  @:type("hidden") @:optional var onHidden(default, never):Callback<UIEvent>;
  @:type("shown") @:optional var onShown(default, never):Callback<UIEvent>;
  @:type("enabled") @:optional var onEnabled(default, never):Callback<UIEvent>;
  @:type("disabled") @:optional var onDisabled(default, never):Callback<UIEvent>;
  @:type("ValidationStart") @:optional var onValidationStart(default, never):Callback<ValidationEvent>;
  @:type("ValidationStop") @:optional var onValidationStop(default, never):Callback<ValidationEvent>;
}