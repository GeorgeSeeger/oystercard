require 'journey_log'
require 'journey'

describe JourneyLog do
  subject(:journey_log) { described_class.new(Journey)}
  let(:entry_station) {double(:entry_station)}
  let(:exit_station) {double(:exit_station)}

  it "start should start a new journey with an entry station" do
    journey_log.start(entry_station)
    expect(journey_log.journeys[0]).to be_an_instance_of Journey
  end

  it "should return an incomplete journey" do
    journey_log.start(entry_station)
    expect(journey_log.current_journey).to eq journey_log.journeys.last
  end

  it "should start a new journey if journey is complete" do
    expect(journey_log.current_journey).to be_an_instance_of Journey
  end

  context "complete journey" do

    before (:each) {
      journey_log.start(entry_station)
      journey_log.finish(exit_station)
    }

    it "finish should add an exit station to the current journey" do
      expect(journey_log.journeys.last).to be_complete
    end

    it "should return a list of all previous journeys" do
      journey_log.start(entry_station)
      journey_log.finish(exit_station)
      expect(journey_log.journeys.length).to eq 2
    end

  end

  it "should not allow modificatons to the journeys array" do
    expect{journey_log.journeys.push(:test)}.to raise_error(RuntimeError)
  end
end
