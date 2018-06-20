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
  end
  
  #
  # def fare
  # end
  #
  # def in_journey?
  # end

end
