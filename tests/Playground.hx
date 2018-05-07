package;

import coconut.haxeui.*;
import coconut.ui.*;
import Playground.*;

import haxe.ui.*;
import haxe.ui.core.*;

class Playground {
	static function main() {
		Toolkit.init();
		Screen.instance.addComponent(new MyView({}).toComponent());
	}
	
	// static public function vbox(attr:{}, children:Children)
	// 	return Node.make(haxe.ui.containers.VBox, attr, children);

	// static public function button(attr:{text:String, ?onClick:MouseEvent->Void})
	// 	return Node.make(haxe.ui.components.Button, attr);

	// static public function label(attr:{text:String})
	// 	return Node.make(haxe.ui.components.Label, attr);

	static var EMPTY = [];
}

class MyView extends coconut.ui.View {
	@:state var counter:Int = 0;
	@:state var click:Int = 0;
	
	function render() '
		<VBox>
			<Button text="Button $counter" onClick={click++} />
			<Label text="Clicked $click times" />
			<ComplexButton title="Complex Button $counter" />
		</VBox>
	';
	
	override function afterInit(c) {
		new haxe.Timer(1000).run = function() {
			counter += 1;
		}
	}
}

class ComplexButton extends coconut.ui.View {
	@:attribute var title:String;
	function render() '<Button text=$title />';

}