require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:oystercard) { Oystercard.new }
  let(:min) { Oystercard::MIN_BALANCE }
  let(:max) { Oystercard::MAX_BALANCE }

  describe '#balance' do
    it 'Starts with a balance of zero' do
      expect(oystercard.balance).to eq(0)
    end
  end

  describe '#top_up()' do
    it 'Tops up the balance with method argument' do
      expect { oystercard.top_up 10 }.to change { oystercard.balance }.by 10
    end

    it 'Raises an error if limit is exceeded' do
      oystercard.top_up(max)
      error = "Maximum limit of £#{max} exceeded."
      expect { oystercard.top_up(1) }.to raise_error(error)
    end
  end

  describe '#deduct()' do
    it 'Deduct the balance with method argument' do
      expect { oystercard.send(:deduct, 10) }.to \
        change { oystercard.balance }.by(-10)
    end
  end

  it { is_expected.to respond_to(:touch_in).with(1).argument }
  it { is_expected.to respond_to(:touch_out).with(1).argument }

  describe '#touch_in' do
    it 'Changes in_journey to true' do
      oystercard.instance_variable_set(:@balance, min)
      oystercard.touch_in(entry_station)
      expect(oystercard.in_journey?).to eq true
    end

    it 'touch_in without minimum balance raises error' do
      error = "Insufficient Funds: Must have at least £#{min}"
      expect { oystercard.touch_in(entry_station) }.to raise_error(error)
    end

    it 'should remember entry_station after touch_in' do
      oystercard.top_up(min)
      expect { oystercard.touch_in(entry_station) }.to \
        change { oystercard.entry_station }.to entry_station
    end
  end

  describe '#touch_out' do

    it 'Changes entry_station to nil' do
      oystercard.instance_variable_set(:@balance, min)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.entry_station).to eq nil
    end

    it 'Deducts the minimum fare when #touch_out is called' do
      oystercard.instance_variable_set(:@balance, min)
      oystercard.touch_in(entry_station)
      expect { oystercard.touch_out(exit_station) }.to \
        change { oystercard.balance }.by(-min)
    end

    it '#touch_out pushes complete journey into @journeys' do
      oystercard.top_up(min)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.journeys).to eq(entry_station => exit_station)
    end
  end

  describe '#in_journey?' do
    it 'Returns true or false' do
      expect(oystercard.in_journey?).to eq(true).or eq(false)
    end
  end

  describe '@journeys' do
    it 'Initializes with an empty @journeys hash' do
      expect(oystercard.journeys).to eq({})
    end
  end
end
