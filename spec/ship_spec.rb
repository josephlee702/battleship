require './lib/ship'

RSpec.describe Ship do
  describe '#instantiate' do
    it 'instantiates a ship' do
      cruiser = Ship.new("Cruiser", 3)
      expect(cruiser).to be_an_instance_of(Ship)
      expect(cruiser.name).to eq("Cruiser")
      expect(cruiser.length).to eq(3)
    end
  end

  describe 'boat gets hit and sunk' do
    it 'hits the boat and sinks it' do
      cruiser = Ship.new("Cruiser", 3)
      expect(cruiser.health).to eq(3)
      expect(cruiser.sunk?).to be false
      cruiser.hit
      expect(cruiser.health).to eq(2)
      cruiser.hit
      expect(cruiser.health).to eq(1)
      cruiser.hit
      expect(cruiser.sunk?).to be true
    end
  end
end