package mutation.ui.screens 
{
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import mutation.entity.BaseDescriptor;
	import mutation.events.ButtonEvent;
	import mutation.events.ContractEvent;
	import mutation.Game;
	import mutation.Main;
	import mutation.ui.contracts.ContractDescriptor;
	import mutation.ui.contracts.ContractOption;
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
			
			updateContracts(false);
			draw();
			
			for each (var o:ContractOption in options){
				o.addEventListener(ContractEvent.SELECTED, onSelected);
			}
			
			if (stage){
				parent.addChildAt(this, parent.numChildren - 1);
			}
			stage.addEventListener(ContractEvent.COMPLETED, onContractComplete);
		}
		
		
		public function kill():void
		{	
			if(stage){
				stage.removeEventListener(ContractEvent.COMPLETED, onContractComplete);
			}
			for each (var o:ContractOption in options) {
				o.kill();
				o.removeEventListener(ContractEvent.SELECTED, onSelected);
			}
			
		}

		
		private function onSelected(e:ContractEvent):void
		{
			dispatchEvent(new ContractEvent(ContractEvent.SELECTED, e.contract));
			this.visible = false;
		}
		
		
		private function draw():void
		{
			graphics.clear();
			graphics.beginFill(0xFFFFFF, 0.25);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			
			var colours:Array = [0x597DA5, 0x325EB8,  0x87AAEA, 0x6699CC];
			var alphas:Array  = [0.25, 0.25, 0.25, 1];
			var ratios:Array  = [180 , 200 , 201 , 255];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(stage.stageWidth, stage.stageHeight, 90*(Math.PI/180), 0 , 0);
			
			graphics.beginGradientFill(GradientType.LINEAR, colours, alphas, ratios, matrix);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
		}
		
		
		public function updateContracts(initialised:Boolean):void
		{
			var loaded:int = 0;
			
			//	Clear the previous list, to ensure "old" elements aren't left accidentally
			if (initialised) {
					for each (var o:ContractOption in options){
						o.removeEventListener(ContractEvent.SELECTED, onSelected);
						removeChild(o);
					}
					//	Remove all entries from the option array
					for each (var o:ContractOption in options){
						options.pop();
					}
			}
			
			//	Gather the next set of valid contracts (3 at most)	
			for (var i:int = 1; i < game.contracts.unlocked.length; ++i) {
				if (loaded >= 3) break;
				
				var c:ContractDescriptor = game.contracts.getAt(i) as ContractDescriptor;
				if (c.group < group) continue;
				if (c.hasRequirement) {
					if (!(game.contracts.getAt(c.requirement) as ContractDescriptor).isComplete) continue;
				}
				
				options[loaded]		= new ContractOption(game, c ) ;
				addChild(options[loaded]);
				options[loaded].addEventListener(ContractEvent.SELECTED, onSelected);
				loaded++;
			}
			
			//	if nothing was loaded - game is empty of content - add a continuous contract
			if (loaded < 1) {
				options[0]		= new ContractOption(game, game.contracts.getAt(0) as ContractDescriptor) ;
				addChild(options[0]);
				options[0].addEventListener(ContractEvent.SELECTED, onSelected);
				loaded++;
			}
			
			//	layout the options evenly across the screen evenly across the center
			for (var i:int = 0; i < loaded; ++i) {
				options[i].x = (stage.stageWidth / 2 ) - (loaded* 180 / 2) + (i * 180);
				options[i].y = 50;
			}
		}
		
		
		private function onContractComplete(e:ContractEvent):void
		{
			Main.isPaused = true;
			visible = true;
			if (stage){
				parent.addChildAt(this, parent.numChildren - 1);
			}
			group = e.contract.type.next;
			e.contract.type.isComplete = true;
			updateContracts(true);
		}
		
	}

}