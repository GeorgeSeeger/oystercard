require 'station'

describe Station do
  subject(:station){ Station.new(:aldgate_east, 1)}
  it { is_expected.to respond_to(:name) }

  it { is_expected. to respond_to(:zone) }

  it "should have a name" do
    expect(station.name).to eq :aldgate_east
  end

  it "should have a zone" do
    expect(station.zone).to eq 1
  end
end
