require './lib/ship'
require './lib/cell'

RSpec.describe Cell do 
  describe '#instantiate' do 
    it 'instantiates a cell' do
      cell = Cell.new("B4")
      expect(cell).to be_an_instance_of(Cell)
      expect(cell.coordinate).to eq("B4")
      expect(cell.ship).to be nil
      expect(cell.empty?).to be(true)
    end
  end

  describe 'instantiate placing a ship' do 
    it 'places ship' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)
      expect(cell.ship).to eq(cruiser)
      expect(cell.empty?).to be(false)
    end
  end
end
