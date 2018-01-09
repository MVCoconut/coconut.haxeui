package;

// import coconut.Ui.*;
import coconut.haxeui.*;
import haxe.ui.diff.Diff.*;
import Playground.*;

import haxe.ui.*;
import haxe.ui.core.*;

class Playground {
	static function main() {
		Toolkit.init();
		Screen.instance.addComponent(new MyView({}).toComponent());
	}
	
	public static function vbox(attr:{}, children)
		return h('vbox', attr, children);
	public static function button(attr:{text:String, ?onClick:MouseEvent->Void}, children)
		return h('button', attr, children);
	public static function label(attr:{text:String}, children)
		return h('label', attr, children);
}

class MyView extends coconut.ui.View<{}> {
	@:state var counter:Int = 0;
	@:state var click:Int = 0;
	
	function render() {
		return vbox({}, [
			button({text: 'Button $counter', onClick: function(e) click++}, []),
			label({text: 'Clicked $click times'}, []),
			Widget(new ComplexButton({title: 'Complex Button $counter'})), // cache this somehow?
		]);
	}
	
	override function afterInit(c) {
		new haxe.Timer(1000).run = function() {
			counter = counter + 1;
		}
	}
}

class ComplexButton extends coconut.ui.View<{title:String}> {
	function render() return button({text: title}, []);
}