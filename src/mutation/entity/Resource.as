package mutation.entity 
{
	
	public class Resource 
	{
		
		private var amount_:Number;	//	Actual amount of this resource held
		private var rate_:Number;		//	Rate of change per tick
		private var limit_:Number;	//	Largest amount that can be stored
		
		public function Resource(amount:Number = 0, rate:Number = 1, limit:Number = 100 ) 
		{
			setup(amount, rate, limit);
		}
		
		public function update():void
		{
			amount_ += rate_;
			if (amount_ > limit_) amount_ = limit_;
			if (amount_ < 0) amount_ = 0;
		}
		
		public function isFilled():Boolean
		{
			return ((amount_ + rate_) > limit_);
		}
		public function get amount():Number
		{
			return amount_;
		}
		
		public function set amount(value:Number):void
		{
			amount_ = value;
		}
		
		
		public function setup(amount:Number, rate:Number, limit:Number):void
		{
			amount_ = amount;
			rate_ = rate;
			limit_ = limit;
		}
		
		public function alter(amountChange:Number, rateChange:Number, limitChange:Number):void
		{
			amount_ += amountChange;
			rate_ += rateChange;
			limit_ += limitChange;
		}
		
		public function scale(amountScale:Number, rateScale:Number, limitScale:Number):void
		{
			amount_ *= amountScale;
			rate_ *= rateScale;
			limit_ *= limitScale;
		}
	}

}