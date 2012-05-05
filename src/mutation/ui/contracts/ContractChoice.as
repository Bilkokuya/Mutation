package mutation.ui.contracts 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import mutation.entity.BaseDescriptor;
	import mutation.Game;
	import mutation.util.Resources;

	public class ContractChoice extends Sprite
	{
		private var game:Game;

		private var group:int = 0;
		private var options:Vector.<ContractOption> = new Vector.<ContractOption>();
		
		public function ContractChoice(game:Game) 
		{			
			this.game = game;
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			var i:int = 0;
			for each (var cb:BaseDescriptor in game.contracts.unlocked) {
				var c:ContractDescriptor = cb as ContractDescriptor;
				if (i >= 3) break;
				if (c.group < group) continue;
				if (c.hasRequirement) {
					if (!(game.contracts.getAt(c.requirement) as ContractDescriptor).isComplete) continue;
				}
				options[i]		= new ContractOption(game, c ) ;
				options[i].x 	= i * ((stage.stageWidth - 60) / 3) + 40;
				options[i].y	= 50;
				addChild(options[i]);
				i++;
			}
			
			draw();
		}

		private function draw():void
		{
			graphics.beginFill(0x111122, 0.85);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
		}
		
	}

}