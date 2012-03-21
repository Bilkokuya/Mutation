package GDM.tests
{
  import asunit.framework.Assert;
  import asunit.framework.TestCase;
  import GDM.Mutation.events.MutationEvent;
  import GDM.Mutation.objects.Bacteria;

  public class TestFirstTry extends TestCase
  {

    public function TestFirstTry(testMethod:String)
    {
      super(testMethod);
    }

    public function TestIntegerMath() : void
    {
      var i:int = 5;
      assertEquals(5, i);
      i += 4;
      assertEquals(9, i);
    }

    public function TestFloatMath() : void
    {
      var i:Number = 5;
      assertEqualsFloat(5, i, 0.001);
      i += 5;
      assertEqualsFloat(8, i, 0.001);
    }
	
	public function TestBacteria():void
	{
		var bacteria:Bacteria = new Bacteria();
		bacteria.food = 100;
		assertEquals(bacteria.food, 100);
		
		for (var i:int = 0; i < 3600; i++) {
			var e:MutationEvent = new MutationEvent(MutationEvent.TICK);
			e.tickCount = i;
			bacteria.onTick(e);
		}
		
		assertTrue(!bacteria.visible);
	}
	
  }
}
