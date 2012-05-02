package mutation.entity.levelling 
{

	//	Simple levelling used for the Bacteria
	public class SimpleLeveling extends Leveling
	{
		public function SimpleLeveling() 
		{
			super(
				new <Level>[
					new Level(200, 0.999, 1),
					new Level(400, 0.999, 1),
					new Level(600, 0.999, 1),
					new Level(800, 0.999, 1),
					new Level(1000, 0.999, 1),
				]
			);
		}
	}

}