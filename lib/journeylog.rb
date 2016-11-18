require_relative 'journey.rb'

class JourneyLog

attr_reader :journey_class

  def initialize(journey_Klass)
    @journey_class = journey_Klass
    @journeys = []
  end

  def start_journey(station)
    journey_new = journey_class.new
    journey_new.start(station)
    @journeys << journey_new
  end

  def current_journey
    return journeys.last if journeys.last.incomplete?
    return journey_class.new
  end

  def end_journey(station2)
    @journeys.last.end(station2)
  end

  def journeys
    @journeys.dup
  end

end
