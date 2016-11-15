require 'oystercard'

describe Card do

let(:station)  { double("station") }
  before(Card) do
    subject.top_up(5)
  end

  it 'test the a new card an be created' do
    expect(subject).to be_a_kind_of(Card)

  end

  it 'expects a new card to have a starting balance of 0' do
    card2 = Card.new
    expect(card2.balance).to eq Card::STARTING_BALANCE

  end

  it 'expects the be card to be topped up' do
    current_card_balance = subject.balance
    expect(subject.top_up(5)).to eq (current_card_balance + 5)
  end

  it 'it tests that a card has a limit of 30' do
    expect(subject.maximum_balance).to eq 90
  end

  it 'expects the user not to be able to top-up over card limit' do
    message = "You cannot top-up over your limit of #{subject.maximum_balance}"
    expect{subject.top_up(100)}.to raise_error message
  end

  it 'checks if a card is not in use' do
    expect(subject.in_journey?).to be false
  end

  it 'expect a card to be "in use" once touched in' do
    subject.touch_in(station)
    expect(subject.in_journey?).to be true
  end

  it 'expect a card not to be "in use" once touched out' do
    subject.touch_in(station)
    subject.touch_out(Card::MINIMUM_FARE)
    expect(subject.in_journey?).to be false 
  end

  it 'expect user to not be able to touch in when balance is less than the minimum fare' do
    card2 = Card.new
    expect{ card2.touch_in(station)}.to raise_error ("Insufficient funds")
  end

  it 'expect a "touch_out" to deduct the minimum fare' do
    expect{subject.touch_out(Card::MINIMUM_FARE)}.to change(subject, :balance).by -Card::MINIMUM_FARE
  end

  it 'expects card to store entry station upon touching in' do
    expect(subject.touch_in(station)).to eq (subject.entry_station)
  end
end
