require 'journey'

describe Journey do

  it { is_expected.to respond_to(:start).with(1).argument }

  it { is_expected.to respond_to(:finish).with(1).argument }

  describe '#initialize' do
    it 'initializes with an empty history hash' do
      expect(subject.history).to eq ({})
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
  #
  # it { is_expected.to respond_to(:fare) }
  #
  # it { is_expected.to respond_to(:in_journey?) }

end
