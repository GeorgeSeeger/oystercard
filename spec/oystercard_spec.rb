require 'oystercard'

describe Card do

  it 'test the a new card an be created' do
    expect(subject).to be_a_kind_of(Card)

  end

  it 'expects a new card to have a starting balance of 0' do
    expect(subject.balance).to eq Card::STARTING_BALANCE

  end

  it 'expects the be card to be topped up' do
    card_starting_balance = subject.balance
    expect(subject.top_up(5)).to eq (card_starting_balance + 5)
  end

  it 'it tests that a card has a limit of 30' do
    expect(subject.maximum_balance).to eq 90
  end

  it 'expects the user not to be able to top-up over card limit' do
    message = "You cannot top-up over your limit of #{subject.maximum_balance}"
    expect{subject.top_up(91)}.to raise_error message
  end

  it 'expects the card balance to be deducted by fare' do
    fare = 3
    pre_journey_balance = subject.top_up(5)
    expect(subject.deduct(fare)).to eq (pre_journey_balance - fare)
  end

  it 'checks if a card is not in use' do
    expect(subject.in_journey?).to be false
  end

  it 'expect a card to be "in use" once touched in' do
    subject.top_up(2)
    expect{subject.touch_in(1)}.to change(subject, :in_journey).to true
  end

  it 'expect a card not to be "in use" once touched out' do
    subject.top_up(2)
    subject.touch_in(1)
    expect{subject.touch_out}.to change(subject, :in_journey).to false
  end

  it 'expect user to not be able to touch in when balance < 1' do
    expect{ subject.touch_in(1) }.to raise_error ("Insufficient funds")
  end

end
