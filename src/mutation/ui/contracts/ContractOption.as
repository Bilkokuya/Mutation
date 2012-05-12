package mutation.ui.contracts 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import mutation.events.ContractEvent;
	import mutation.Game;
	import mutation.util.Resources;

	public class ContractOption extends Sprite
	{
		private var game:Game;
		private var option:Bitmap;
		
		private var titleOut:TextField;
		private var descOut:TextField;
		
		private var type:ContractDescriptor;
		
		public function ContractOption(game:Game, descriptor:ContractDescriptor) 
		{
			this.game = game;
			
			this.type = descriptor;
			
			titleOut = new TextField();
			descOut = new TextField();
			option  = new Resources.GFX_UI_MENU;
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			
			titleOut.text = type.title;
			titleOut.autoSize = TextFieldAutoSize.LEFT;
			titleOut.x = 25;
			titleOut.y = 20;
			titleOut.wordWrap = true;
			titleOut.width = 100;
			
			descOut.text = type.description;
			descOut.autoSize = TextFieldAutoSize.LEFT;
			descOut.x = 25;
			descOut.y  = 40;
			descOut.wordWrap = true;
			descOut.width = 100;
			
			addChild(option);
			addChild(titleOut);
			addChild(descOut);
			
			addEventListener(MouseEvent.CLICK, onClick);
		}

		private function onClick(e:MouseEvent):void
		{
			dispatchEvent(new ContractEvent(ContractEvent.SELECTED, new Contract(stage, type))) ;
		}
		
	}

}