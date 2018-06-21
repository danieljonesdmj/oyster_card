require './lib/journey'

class Oystercard
  attr_reader :balance, :entry_station, :journey, :all_history
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @all_history = []
  end

  def top_up(amount)
    raise "Maximum limit of £#{MAX_BALANCE} exceeded." if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Insufficient Funds: Must have at least £#{MIN_BALANCE}" if balance < MIN_BALANCE
    @journey = Journey.new
    @journey.start(entry_station)
  end

  def touch_out(exit_station)
    @journey.finish(exit_station)
    deduct(@journey.fare)
    store_journey
  end

  # private
  def store_journey
    @all_history << @journey.history
  end

  def deduct(amount)
    @balance -= amount
  end
end
