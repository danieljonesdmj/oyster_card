class Oystercard

  attr_reader :balance
  attr_reader :entry_station
  attr_reader :journeys
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = {}
  end

  def top_up(amount)
    fail "Maximum limit of #{MAX_BALANCE} exceeded." if balance + amount > MAX_BALANCE
    @balance += amount
  end


  def touch_in(station)
    fail "Insufficient Funds" if balance < MIN_BALANCE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_BALANCE)
    @journeys[@entry_station] = station
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
