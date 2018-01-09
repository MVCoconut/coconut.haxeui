package;

// import coconut.Ui.*;
import coconut.haxeui.*;
import haxe.ui.diff.Diff.*;

import haxe.ui.*;
import haxe.ui.core.*;

class Playground {
	static function main() {
		Toolkit.init();
		Screen.instance.addComponent(new MyView({}).toComponent());
	}
	
	public static function button(attr:{text:String}, children)
		return h('button', attr, children);
}

class MyView extends coconut.ui.View<{}> {
	@:state var counter:Int = 0;
	
	function render() {
		return Playground.button({text: 'Button $counter'}, []);
	}
	
	override function afterInit(c) {
		new haxe.Timer(1000).run = function() {
			counter = counter + 1;
		}
	}
}