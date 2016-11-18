require_relative './journey'
require_relative './journey_log'

class OysterCard
  MAXIMUM_LIMIT = 90
  MINIMUM_LIMIT = 1

  attr_reader :balance, :journey_log

  def initialize(journey)
    @journey_log = JourneyLog.new(Journey)
    @balance = 0
  end

  def top_up(value)
    raise "Cannot top up: £#{MAXIMUM_LIMIT} limit would be exceeded" if limit_exceeded?(value)
    self.balance += value
  end


  def touch_in(entry_station)
    raise "Error: Insufficient balance, please top up." if insufficient_funds?
    no_touch_out_penalty
    self.journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    deduct(self.journey_log.finish(exit_station).fare)
  end


  private

  attr_writer :balance

  def limit_exceeded?(value)
    self.balance + value > MAXIMUM_LIMIT
  end

  def insufficient_funds?
    self.balance < MINIMUM_LIMIT
  end

  def deduct(value)
    self.balance -= value
  end

  def no_touch_out_penalty
    deduct(Journey::PENALTY_FARE) if self.journey_log.current_journey.incomplete?
  end
end
