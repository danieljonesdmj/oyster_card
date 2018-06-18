require 'oystercard'

describe Oystercard do
  describe '#balance' do
    it 'Starts with a balance of zero' do
      expect(Oystercard.new.balance).to eq(0)
    end
  end
end
