class Oystercard

  attr_reader :balance
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Maximum limit of #{MAX_BALANCE} exceeded." if balance + amount > MAX_BALANCE
    @balance += amount
  end


  def touch_in
    fail "Insufficient Funds" if balance < MIN_BALANCE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MIN_BALANCE)
  end

  def in_journey?
    @in_journey
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
