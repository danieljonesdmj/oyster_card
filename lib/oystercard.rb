class Oystercard

  attr_reader :balance
  attr_reader :entry_station
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    fail "Maximum limit of #{MAX_BALANCE} exceeded." if balance + amount > MAX_BALANCE
    @balance += amount
  end


  def touch_in(station)
    fail "Insufficient Funds" if balance < MIN_BALANCE
    @entry_station = station
  end

  def touch_out
    @entry_station = nil
    deduct(MIN_BALANCE)
  end

  def in_journey?
    !!entry_station
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
