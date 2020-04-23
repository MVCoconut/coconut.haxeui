package;

import coconut.ui.*;
import coconut.haxeui.*;
// import Playground.*;

import haxe.ui.*;
import haxe.ui.core.*;
import haxe.ui.components.*;
import haxe.ui.containers.*;

class Playground {
	static function main() {


		var root = new Component();
		Screen.instance.addComponent(root);
		root.width = 500;
		root.height = 500;
		Renderer.mount(
			root,
			'<MyView />'
		);

		Toolkit.init();
	}

	static var EMPTY = [];
}

class MyView extends View {
	@:state var counter:Int = 0;
	@:state var click:Int = 0;

	function render() '
		<VBox>
			<Button text="Button $counter" onClick=${click++} />
			<Label text="Clicked $click times" />
			<ComplexButton title="Complex Button $counter" />
		</VBox>
	';

	override function viewDidMount() {
		new haxe.Timer(1000).run = function() {
			counter += 1;
		}
	}
}

class ComplexButton extends View {
	@:attribute var title:String;
	function render() '<Button text=$title />';

}