require 'oystercard'

describe OysterCard do
  subject(:oystercard) {described_class.new(Journey)}

  describe "#top_up" do
    it "should increase the balance by top_up value" do
      oystercard.top_up(10)
      expect(oystercard.balance).to eq 10
    end

    it "should raise an error if max. limit is exceeeded" do
      message = "Cannot top up: £#{OysterCard::MAXIMUM_LIMIT} limit would be exceeded"
      expect {oystercard.top_up(100)}.to raise_error(message)
    end
  end

  context "journey" do
    let(:entry_station) {double :entry_station, :zone => 1}
  let(:exit_station) {double :exit_station, :zone => 1 }

    describe "#touch_in" do

      it "refuses to let you touch in unless the balance is at least £#{OysterCard::MINIMUM_LIMIT}" do
        message = "Error: Insufficient balance, please top up."
        expect {oystercard.touch_in(entry_station)}.to raise_error(message)
      end
    end

    it "charges penalty fare if user forgot to touch out" do
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
      expect{oystercard.touch_in(entry_station)}.to change{oystercard.balance}.by(-Journey::PENALTY_FARE)
    end

    describe "#touch_out" do

      it "deducts a fare on completion of a journey" do
        oystercard.top_up(10)
        oystercard.touch_in(entry_station)
        expect {oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-Journey::MINIMUM_FARE)
      end

      it "charges penalty fare if user forgot to touch in" do
        oystercard.top_up(10)
        expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-Journey::PENALTY_FARE)
      end
    end
  end

end
