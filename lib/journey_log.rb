class JourneyLog

  def initialize(journey_klass)
    @journey_class = journey_klass
    @journeys = []
  end

  def start(entry_station)
    @journeys << start_journey(entry_station)
  end

  def current_journey
    return @journey_class.new if last_incomplete?
    @journeys.last
  end

  def finish(exit_station)
    current_journey.register_exit_station(exit_station)
  end

  def journeys
    @journeys.dup.freeze
  end

  private

  def make_journey
    @journey_class.new
  end

  def start_journey(entry_station)
    make_journey.register_entry_station(entry_station)
  end

  def last_incomplete?
    @journeys.empty? || @journeys.last.complete?
  end
end
