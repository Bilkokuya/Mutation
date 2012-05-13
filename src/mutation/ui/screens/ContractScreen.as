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

	public class ContractScreen extends Screen
	{
		private var game:Game;
		
		private var group:int = 0;
		private var options:Vector.<ContractOption> = new Vector.<ContractOption>();
		
		//	Simple constructor
		public function ContractScreen(game:Game) 
		{	
			this.game = game;

			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		//	Initialisation after the stage
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			updateContracts(false);
			
			for each (var o:ContractOption in options){
				o.addEventListener(ContractEvent.SELECTED, onSelected);
			}
			
			if (stage){
				parent.addChildAt(this, parent.numChildren - 1);
			}
			stage.addEventListener(ContractEvent.COMPLETED, onContractComplete);
		}
		
		//	Safely kills all stage/event references
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

		//	Called when a contract has been selected
		private function onSelected(e:ContractEvent):void
		{
			dispatchEvent(new ContractEvent(ContractEvent.SELECTED, e.contract));
			this.visible = false;
		}
		
		//	Called when the contracts need updating
		public function updateContracts(initialised:Boolean):void
		{
			var loaded:int = 0;
			
			//	Clear the previous list, to ensure "old" elements aren't left accidentally
			if (initialised) {
				trace("starting removals: " + options.length);
					for (var i:int = options.length; i > 0 ; i--) {
						var o:ContractOption = options.pop();
						o.removeEventListener(ContractEvent.SELECTED, onSelected);
						removeChild(o);
						trace("removed option");
					}
					trace("options removed");
			}else {
				trace("no removal, not initialised");
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
		
		//	Called when a contract is complete
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