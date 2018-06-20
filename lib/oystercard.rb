class Oystercard
  attr_reader :balance, :entry_station, :journeys
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    raise "Maximum limit of £#{MAX_BALANCE} exceeded." if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in
    raise "Insufficient Funds: Must have at least £#{MIN_BALANCE}" if balance < MIN_BALANCE
  end

  def touch_out
    deduct(MIN_BALANCE)
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
