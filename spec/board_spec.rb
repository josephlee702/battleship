require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Board do 
  before(:each) do 
    @board = Board.new 
    @board.cells
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2 )
  end
  
  describe 'Makes it exist'do 
    it 'exist' do 
      expect(@board).to be_an_instance_of(Board)
    end
  end

  describe ' Cell' do 
    it 'creates cells with hash' do 
      expect(@board.coordinates).to be_a(Hash)
      expect(@board.coordinates.length).to eq(16)
      @board.coordinates.each do |coordinate, cell_obj|
      expect(cell_obj).to be_an_instance_of(Cell)
      end 
    end
  end
end