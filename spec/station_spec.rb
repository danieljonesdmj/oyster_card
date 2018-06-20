require 'station'

describe Station do
  let(:station) { Station.new('Oxford St', 'zone_1') }
  describe 'return what zone a station is in' do
    it 'knows what it is name is' do
      expect(station.name).to eq 'Oxford St'
    end

    it 'knows what zone it is in' do
      expect(station.zone).to eq 'zone_1'
    end
  end
end
