require 'journeylog'
require 'journey'

describe JourneyLog do
  subject(:journeylog) {described_class.new(Journey)}
  let(:station) { double :station, :zone => 1 }
  let(:station2) { double :station2, :zone => 1 }

    it "should test that journeys should be a tyoe of array" do
      expect(journeylog.journeys).to be_kind_of Array
    end

    it "should start journey when card touches in" do
      journeylog.start_journey(station)
      expect(journeylog.journeys[0]).to be_kind_of Journey
    end

    it "should return an incomplete journey" do
      journeylog.start_journey(station)
      incomplete_journey = journeylog.journeys.last
      expect(journeylog.current_journey).to eq incomplete_journey
    end

    it "should return a new journey if last is complete" do
      journeylog.start_journey(station)
      journeylog.end_journey(station2)
      expect(journeylog.current_journey).to be_kind_of Journey
      expect(journeylog.current_journey).not_to be eq journeylog.journeys.first
    end

    it "should return exit station at the end of journey" do
      journeylog.start_journey(station)
      journeylog.end_journey(station2)
      expect(journeylog.journeys.last).not_to be_incomplete
    end

end
