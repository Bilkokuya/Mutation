package mutation.ui 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import mutation.util.Resources;

	public class ContractChoice extends Sprite
	{
		
		private var option:Sprite;
		private var desc:TextField;
		
		public function ContractChoice() 
		{
			option = new Sprite();
			desc = new TextField();
			
			super();
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			desc.text = Resources.getXML(Resources.XML_CONTRACTS).contract[0].description;
			desc.autoSize = TextFieldAutoSize.LEFT;
			desc.x = 10;
			desc.wordWrap = true;
			desc.width = 130;
			
			addChild(option);
			option.addChild(desc);
			
			option.x = 175;
			option.y = 75;
			draw();
		}
		
		private function draw():void
		{
			graphics.beginFill(0x000000, 0.1);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			
			option.graphics.beginFill(0xFFFFFF);
			option.graphics.drawRect(0, 0, 150, 250);
			option.graphics.endFill();
		}
		
	}

}