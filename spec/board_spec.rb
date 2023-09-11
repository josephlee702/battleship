require 'rspec'
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
      expect(@board.cells).not_to eq({})
      expect(@board.cells.length).to eq(16)
      
    end
  end

  describe 'Valid_coordinate' do 
    it 'checks if coordinate is vaild with True/false' do
      expect(@board.valid_coordinate?("A1")).to be(true)
      expect(@board.valid_coordinate?("D4")).to be(true)
      expect(@board.valid_coordinate?("A5")).to be(false)
      expect(@board.valid_coordinate?("E1")).to be(false)
      expect(@board.valid_coordinate?("A22")).to be(false)
    end
  end

  describe "#valid_placement? array should be same length" do 
    it "coordinates in the array should be the same as the length of the ship" do 
      expect(@board.valid_placement?(@cruiser, ["A2", "A3", "A4"])).to be(true)
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to be(false)
    end
  end
  
  describe '#Valid_placement? coordinates are conseutive' do 
    it'makes sure coordinates are consecutive' do 
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to be(false)
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to be(false)
    end
  end

  describe '#Valid_placement? coordinates cant be diagonal' do 
    it'Makes sure coordinates cant be diagonal' do 
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to be(false)
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to be(false)
    end
  end

  describe '#Valid_placement? If all the previous checks pass then valid' do
    it'Checks and makes sure the placment is valid' do 
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to be(true)
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to be(true)
    end
  end
end