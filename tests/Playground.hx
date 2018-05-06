package;

// import coconut.Ui.*;
import coconut.haxeui.*;
import coconut.ui.*;
import haxe.ui.diff.Diff.*;
import Playground.*;

import haxe.ui.*;
import haxe.ui.core.*;

class Playground {
	static function main() {
		Toolkit.init();
		Screen.instance.addComponent(new MyView({}).toComponent());
	}
	
	public static function vbox(attr:{}, children:Children)
		return h('vbox', attr, cast children);

	public static function button(attr:{text:String, ?onClick:MouseEvent->Void})
		return h('button', attr, EMPTY);

	public static function label(attr:{text:String})
		return h('label', attr, EMPTY);

	static var EMPTY = [];
}

class MyView extends coconut.ui.View {
	@:state var counter:Int = 0;
	@:state var click:Int = 0;
	
	function render() '
		<vbox>
			<button text="Button $counter" onClick={click++} />
			<label text="Clicked $click times" />
			<ComplexButton title="Complex Button $counter" />
		</vbox>
	';
	
	override function afterInit(c) {
		new haxe.Timer(1000).run = function() {
			counter += 1;
		}
	}
}

class ComplexButton extends coconut.ui.View {
	@:attribute var title:String;
	function render() '<button text=$title />';

}