package mutation.entity 
{
	//	Self updating resource, that can be passed by reference
	//	The performance hit of this has been accepted, as it is functionally more useful than standard ints
	public class Resource 
	{
		private var amount_:Number;	//	Actual amount of this resource held
		private var rate_:Number;	//	Rate of change per tick
		private var limit_:Number;	//	Largest amount that can be stored
		
		//	Once set up, the rate and limit will not change
		public function Resource(amount:Number = 0, rate:Number = 1, limit:Number = 100 ) 
		{
			setup(amount, rate, limit);
		}
		
		//	Updates the amount by the rate and stops it from exceeding the limit
		public function update():void
		{
			amount_ += rate_;
			if (amount_ > limit_) amount_ = limit_;
			if (amount_ < 0) amount_ = 0;
		}
		
		//	True when the amount is overflowing the limit
		public function isFilled():Boolean
		{
			return ((amount_ + rate_) > limit_);
		}
		
		//	Accessor for the amount; for older code
		public function get amount():Number
		{
			return amount_;
		}
		
		//	Accessor to set the amount; for older code
		public function set amount(value:Number):void
		{
			amount_ = value;
		}
		
		//	Re-initialises the values held. Can be used for when a hat is changed etc
		public function setup(amount:Number, rate:Number, limit:Number):void
		{
			amount_ = amount;
			rate_ = rate;
			limit_ = limit;
		}
		
		//	Alters the values by te given amout
		public function alter(amountChange:Number, rateChange:Number, limitChange:Number):void
		{
			amount_ += amountChange;
			rate_ += rateChange;
			limit_ += limitChange;
		}
		
		//	Scales all the values by the given factors
		public function scale(amountScale:Number, rateScale:Number, limitScale:Number):void
		{
			amount_ *= amountScale;
			rate_ *= rateScale;
			limit_ *= limitScale;
		}
	}

}