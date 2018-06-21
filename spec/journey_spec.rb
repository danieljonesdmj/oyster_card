require 'journey'

describe Journey do

  it { is_expected.to respond_to(:start).with(1).argument }

  it { is_expected.to respond_to(:finish).with(1).argument }

  it { is_expected.to respond_to(:complete?) }

  it { is_expected.to respond_to(:fare) }

  it { is_expected.to respond_to(:penalty?) }

  it { is_expected.to respond_to(:no_touch_in?) }

  it { is_expected.to respond_to(:no_touch_out?) }

  describe '#initialize' do
    it 'initializes with an empty history hash' do
      expect(subject.history).to eq({})
    end
  end

  describe '#start' do
    it 'stores the entry station in the history hash' do
      subject.start('Oxford St')
      expect(subject.history).to eq 'Oxford St' => nil
    end
    it 'sets the entry_station as an instance variable' do
      subject.start('Oxford St')
      expect(subject.entry_station).to eq 'Oxford St'
    end
  end

  describe '#finish' do
    it 'stores the exit station in the history hash' do
      subject.start('Oxford St')
      subject.finish('Notting Hill')
      expect(subject.history).to eq 'Oxford St' => 'Notting Hill'
    end
    it 'checks if exit station is nil' do
      subject.start('Oxford St')
      subject.finish(nil)
      expect(subject.no_touch_out?).to eq true
    end
    it 'checks if entry station is nil' do
      subject.start(nil)
      subject.finish('Oxford St')
      expect(subject.no_touch_in?).to eq true
    end
  end

  describe '#penalty?' do
    it 'returns penalty fare' do
      subject.start(nil || 'Oxford St')
      subject.finish('Victoria' || nil)
      expect(subject.penalty?).to eq false
    end
  end

  describe '#fare' do
    it 'returns minimum fare' do
      subject.start('Oxford St')
      subject.finish('Victoria')
      expect(subject.fare).to eq(Oystercard::MIN_BALANCE)
    end
  end

  describe '#complete?' do
    it 'changes #complete? to false' do
      subject.start('Oxford St')
      expect(subject).not_to be_complete
    end
    it 'changes #complete? to true' do
      subject.start('Oxford St')
      subject.finish('Notting Hill')
      expect(subject).to be_complete
    end
  end
end
