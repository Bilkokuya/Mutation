package mutation.ui.contracts 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import mutation.Game;

	public class ContractOption extends Sprite
	{
		private var game:Game;
		private var option:Sprite;
		private var desc:TextField;
		private var type:ContractDescriptor;
		
		public function ContractOption(game:Game, descriptor:ContractDescriptor) 
		{
			this.game = game;
			
			this.type = descriptor;
			
			desc = new TextField();
			option = new Sprite();
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			desc.text = type.description;
			desc.autoSize = TextFieldAutoSize.LEFT;
			desc.x = 10;
			desc.wordWrap = true;
			desc.width = 130;
			
			addChild(option);
			option.addChild(desc);
			
			draw();
		}
		
		private function draw():void
		{		
			option.graphics.beginFill(0xFFFFFF);
			option.graphics.drawRect(0, 0, 150, 250);
			option.graphics.endFill();
		}
		
	}

}