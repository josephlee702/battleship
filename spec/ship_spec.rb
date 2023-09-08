require './lib/ship'

RSpec.describe Ship do
  describe '#instantiate' do
    it 'instantiates a ship' do
      cruiser = Ship.new("Cruiser", 3)
      expect(cruiser).to be_an_instance_of(Ship)
      expect(cruiser.name).to eq("Cruiser")
      expect(cruiser.length).to eq(3)
      expect(cruiser.health).to eq(3)
    end
  end
end