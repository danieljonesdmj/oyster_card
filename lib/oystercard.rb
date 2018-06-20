class Oystercard
  attr_reader :balance, :entry_station, :journeys
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = {}
  end

  def top_up(amount)
    raise "Maximum limit of £#{MAX_BALANCE} exceeded." if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Insufficient Funds: Must have at least £#{MIN_BALANCE}" if balance < MIN_BALANCE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_BALANCE)
    @journeys[@entry_station] = exit_station
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
