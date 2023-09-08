require './lib/ship'
require './lib/cell'

RSpec.describe Cell do 
  before(:each) do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe '#instantiate' do 
    it 'instantiates a cell' do
      expect(@cell).to be_an_instance_of(Cell)
      expect(@cell.coordinate).to eq("B4")
      expect(@cell.ship).to be nil
      expect(@cell.empty?).to be(true)
    end
  end

  describe 'instantiate placing a ship' do 
    it 'places ship' do
      @cell.place_ship(@cruiser)
      expect(@cell.ship).to eq(@cruiser)
      expect(@cell.empty?).to be(false)
    end
  end

  describe 'Fired upon' do 
    it 'Fired and loses health' do
      @cell.place_ship(@cruiser)
      expect(@cell.fired_upon?).to be(false)
      @cell.fire_upon
      expect(@cell.ship.health).to eq(2)
      expect(@cell.fired_upon?).to be(true)
    end
  end
end
