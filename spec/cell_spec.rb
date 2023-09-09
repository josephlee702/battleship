require './lib/ship'
require './lib/cell'

RSpec.describe Cell do 
  before(:each) do
    @cell_1 = Cell.new("B4")
    @cell_2 = Cell.new("C3")
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe '#instantiate' do 
    it 'instantiates a cell' do
      expect(@cell_1).to be_an_instance_of(Cell)
      expect(@cell_1.coordinate).to eq("B4")
      expect(@cell_1.ship).to be nil
      expect(@cell_1.empty?).to be(true)
    end
  end

  describe '#instantiate placing a ship' do 
    it 'places ship' do
      @cell_1.place_ship(@cruiser)
      expect(@cell_1.ship).to eq(@cruiser)
      expect(@cell_1.empty?).to be(false)
    end
  end

  describe '#fired upon' do 
    it 'fired and loses health' do
      @cell_1.place_ship(@cruiser)
      expect(@cell_1.fired_upon?).to be(false)
      @cell_1.fire_upon
      expect(@cell_1.ship.health).to eq(2)
      expect(@cell_1.fired_upon?).to be(true)
    end
  end

  describe '#render' do
    it 'renders on cell_1' do
      expect(@cell_1.render).to eq(".")
      @cell_1.fire_upon
      expect(@cell_1.render).to eq("M")
    end
  end
end
