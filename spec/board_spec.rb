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
end