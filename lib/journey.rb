class Journey

  attr_reader :history, :entry_station

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

  # def bad_journey?
  #   history.include?(nil)
  # end

  def fare
  end

  def complete?
    !entry_station
  end
end
