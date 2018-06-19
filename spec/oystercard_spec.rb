require 'oystercard'

describe Oystercard do
  let(:station) { double :station }
  let(:station2) { double :station }

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
        expect{subject.send(:deduct, 10)}. to change{subject.balance}.by(-10)
      end
    end

    describe '#touch_in' do
      it 'Changes in_journey to true' do
        subject.instance_variable_set(:@balance, Oystercard::MIN_BALANCE)
        subject.touch_in(station)
        expect(subject.in_journey?).to eq true
      end

      it 'touch_in without minimum balance raises error' do
        expect {subject.touch_in(station)}.to raise_error "Insufficient Funds"
      end

    end

      it { is_expected.to respond_to(:touch_in).with(1).argument }
      it { is_expected.to respond_to(:touch_out).with(1).argument }


      it 'should remember entry station after touch_in' do
        subject.top_up(Oystercard::MIN_BALANCE)
        expect { subject.touch_in(station) }. to change { subject.entry_station }.to station
      end
    end

    describe '#touch_out' do
      it 'Changes entry_station to nil' do
        subject.instance_variable_set(:@balance, Oystercard::MIN_BALANCE)
        subject.touch_in(station)
        subject.touch_out(station)
        expect(subject.entry_station).to eq nil
      end

      it 'Deducts the minimum fare when #touch_out is called' do
        subject.instance_variable_set(:@balance, Oystercard::MIN_BALANCE)
        subject.touch_in(station)
        expect { subject.touch_out(station) }. to change { subject.balance }.by(-Oystercard::MIN_BALANCE)
      end

      it 'touch_out pushes complete journey into @journeys' do
        subject.top_up(Oystercard::MIN_BALANCE)
        subject.touch_in(station)
        subject.touch_out(station2)
        expect(subject.journeys).to eq(station => station2)
      end
    end

    describe '#in_journey?' do
      it 'Returns true or false' do
        expect(subject.in_journey?).to eq(true).or eq(false)
      end
    end

    describe '@journeys' do
      it 'Initializes with an empty @journeys hash' do
        expect(subject.journeys).to eq({})
      end
    end
  end
