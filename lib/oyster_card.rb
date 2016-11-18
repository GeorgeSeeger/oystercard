require_relative 'journeylog.rb'

class Oystercard

attr_reader :balance, :entry_station, :journey_log

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @journey_log = JourneyLog.new(Journey)
  end

  def top_up(amount)
    fail "Card cannot be loaded over £#{MAXIMUM_BALANCE}." if self.balance + amount > MAXIMUM_BALANCE
    self.balance += amount
  end


  def touch_in(entry_station)
    fail "Not enough funds to travel" if self.balance < MINIMUM_BALANCE
    check_previous_journey
    create_journey(entry_station)
    @entry_station = entry_station
  end


  def in_journey?
    !@entry_station.nil?
  end

  def touch_out(exit_station)
    journey_log.end_journey(exit_station)
    deduct(journey_log.journeys.last.fare)
    @entry_station = nil
  end

  private
    attr_writer :balance

  def deduct(amount)
    self.balance -= amount
  end

  def create_journey(entry_station)
    journey_log.start_journey(entry_station)
  end

  def check_previous_journey
    if journey_log.journeys.any? && journey_log.journeys.last.incomplete?
      deduct(journey_log.journeys.last.fare)
    end
  end

end
