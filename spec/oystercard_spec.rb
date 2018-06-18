require 'oystercard'

describe Oystercard do
  describe '#balance' do
    it 'Starts with a balance of zero' do
      expect(Oystercard.new.balance).to eq(0)
    end
  end

  describe '#top_up()' do
    it 'Tops up the balance with method argument' do
      expect{subject.top_up 10}. to change{subject.balance}.by 10
    end

    it 'Raises an error if limit is exceeded' do
      max = Oystercard::MAX_BALANCE
      subject.top_up(max)
      expect{subject.top_up(1)}.to raise_error("Maximum limit of #{max} exceeded.")
    end

    describe '#deduct()' do
      it 'Deduct the balance with method argument' do
        expect{subject.deduct(10)}. to change{subject.balance}.by(-10)
      end
    end
  end
end
