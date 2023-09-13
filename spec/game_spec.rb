require './spec/spec_helper'

RSpec.describe Game do 
  before(:each) do 
    @computer_board = Board.new
    @player_board = Board.new
    @computer_turns = []
    @player_cruiser = Ship.new("cruiser", 3)
    @player_sub = Ship.new("submarine", 2)
    @computer_cruiser = Ship.new("cruiser", 3)
    @computer_sub = Ship.new("submarine", 2)
    @computer_coords = [
      [["A1", "A2", "A3"], ["C2", "C3"]],
      [["A1", "A2", "A3"], ["B1", "B2"]],
      [["A1", "A2", "A3"], ["B2", "B3"]],
      [["A1", "A2", "A3"], ["C3", "C4"]],
      [["A2", "A3", "A4"], ["C1", "D1"]],
      [["A2", "A3", "A4"], ["D1", "D2"]],
      [["A2", "A3", "A4"], ["D3", "D4"]],
      [["A2", "A3", "A4"], ["C2", "C3"]],
    ]
  end

  describe 'Makes it exist'do 
    it 'makes sure all objects exist' do 
      expect(@computer_board).to be_an_instance_of(Board)
      expect(@player_board).to be_an_instance_of(Board)
      expect(@computer_turns).to eq([])
      expect(@player_cruiser).to be_an_instance_of(Ship)
      expect(@player_sub).to be_an_instance_of(Ship)
      expect(@computer_cruiser).to be_an_instance_of(Ship)
      expect(@computer_sub).to be_an_instance_of(Ship)
      expect(@computer_coords).to be_an_instance_of(Array)
    end
  end

  describe 'Makes it exist'do 
    it 'makes sure all objects exist' do 
      
    end
  end
end