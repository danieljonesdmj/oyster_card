class Journey
  attr_reader :history, :entry_station, :all_history

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize
    @history = {}
  end

  def start(entry_station)
    @history[entry_station] = nil
    @entry_station = entry_station
  end

  def finish(exit_station)
    @history[@entry_station] = exit_station
    @entry_station = nil
  end

  def no_touch_in?
    history.key? nil
  end

  def no_touch_out?
    history.value? nil
  end

  def penalty?
    no_touch_in? || no_touch_out?
  end

  def fare
    return PENALTY_FARE if penalty?
    MINIMUM_FARE
  end

  def complete?
    !entry_station
  end
end
