class Journey

  attr_reader :journey_history, :entry_station, :exit_station

  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  def initialize
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
  end

  def complete?
    self.entry_station && self.exit_station
  end

  def incomplete?
    !complete?
  end

  def register_entry_station(station)
    self.entry_station = station
    self
  end

  def register_exit_station(station)
    self.exit_station = station
    self
  end

  def fare
    if complete? then calculate_fare
    else PENALTY_FARE end
  end

  private
  attr_writer :journey_history, :entry_station, :exit_station

  def calculate_fare
    (@entry_station.zone - @exit_station.zone).abs + MINIMUM_FARE
  end

end
