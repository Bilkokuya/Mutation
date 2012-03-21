package GDM.tests
{
  import asunit.framework.TestSuite;

  public class AllTests extends TestSuite
  {
    public function AllTests()
    {
      super();
	  addTest(new TestFirstTry("TestBacteria"));
    }
  }
}