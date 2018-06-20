require 'journey'

describe Journey do

  it { is_expected.to respond_to(:start).with(1).argument }

  it { is_expected.to respond_to(:finish).with(1).argument }

  it { is_expected.to respond_to(:complete?) }

  describe '#initialize' do
    it 'initializes with an empty history hash' do
      expect(subject.history).to eq({})
    end
  end

  describe '#start' do
    it 'stores the entry station in the history hash' do
      subject.start("Oxford St")
      expect(subject.history).to eq "Oxford St" => nil
    end
    it 'sets the entry_station as an instance variable' do
      subject.start("Oxford St")
      expect(subject.entry_station).to eq "Oxford St"
    end
  end

  describe '#finish' do
    it 'stores the exit station in the history hash' do
      subject.start("Oxford St")
      subject.finish("Notting Hill")
      expect(subject.history).to eq "Oxford St" => "Notting Hill"
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

  #
  # it { is_expected.to respond_to(:fare) }
  #


end
