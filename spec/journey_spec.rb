require 'journey'

describe Journey do
subject(:journey) { described_class.new }
let(:entry_station) {double :entry_station, :zone => 1}
let(:exit_station) {double :exit_station, :zone => 1 }

  it "has an empty journey history by default" do
    expect(journey.journey_history).to eq ([])
  end

  it "registers if the journey started" do
    journey.register_entry_station(entry_station)
    expect(journey).to be_incomplete
  end

  it "has an exit station" do
    journey.register_exit_station(exit_station)
    expect(journey.exit_station).to eq exit_station
  end

  it "checks whether journey is incomplete" do
    journey.register_entry_station(entry_station)
    expect(journey).not_to be_complete
  end

  it "checks whether journey is complete" do
    journey.register_entry_station(entry_station)
    journey.register_exit_station(exit_station)
    expect(journey).to be_complete
  end

  it "incurs a penalty fare if no exit station" do
    journey.register_entry_station(entry_station)
    expect(journey.fare).to eq 6
  end

  it "incurs a penalty fare if no entry station" do
    journey.register_exit_station(exit_station)
    expect(journey.fare).to eq 6
  end

  it "incurs a minimum fare if journey is complete" do
    journey.register_entry_station(entry_station)
    journey.register_exit_station(exit_station)
    expect(journey.fare).to eq 1
  end

  context "fares between zones do" do
    let(:aldgate_east) { double( "zn1", zone: 1)}
    let(:whitchapel) { double("zn", zone: 2 )}
    let(:stratford) { double(:zn3, zone: 3 )}
    let(:station4) { double( :zn4, zone: 4)}

    before { journey.register_entry_station(aldgate_east) }

    it "should have a fare of 1 when passing to two zone 1 stations" do
      journey.register_exit_station(aldgate_east)
      expect(journey.fare).to eq 1
    end

    it "should have a fare of 2 between zones 1 and 2" do
      journey.register_exit_station(whitchapel)
      expect(journey.fare).to eq 2
    end

    it "should have a fare of 3 between zones 1 and 3" do
      journey.register_exit_station(stratford)
      expect(journey.fare).to eq 3
    end

  end
end
