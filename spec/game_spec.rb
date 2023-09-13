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

  describe 'Makes it exist' do 
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

  describe 'Computer setup' do 
    it '#computer_turns contains coordinates' do 
      expect(@computer_turns).to eq([])
      @computer_turns = @computer_board.cells.keys
      expect(@computer_turns.count).to eq(16)
      random_coord = [["A2", "A3", "A4"], ["C2", "C3"]]
      expect(random_coord[0]).to eq(["A2", "A3", "A4"])
      expect(random_coord[1]).to eq(["C2", "C3"])
    end

    it '#computer places ship' do 
      random_coord = [["A2", "A3", "A4"], ["C2", "C3"]]
      cruiser_coords = random_coord[0]
      sub_coords = random_coord[1]
      @computer_board.place(@computer_cruiser, random_coord[0])
      @computer_board.place(@computer_sub, random_coord[1])
      expect(@computer_board.cells["A2"].ship).to eq(@computer_cruiser)
      expect(@computer_board.cells["C2"].ship).to eq(@computer_sub)
      expect(@computer_board.cells["A2"].ship). to eq(@computer_board.cells["A3"].ship)
    end
  end

  describe '#player setup' do 
    it '#player places ship' do 
      @player_board.place(@player_cruiser, ["A1", "A2", "A3"])
      expect(@player_board.cells["A1"].ship).to eq(@player_cruiser)
      @player_board.place(@player_sub, ["D2", "D3"])
      expect(@player_board.cells["D3"].ship).to eq(@player_sub)
    end
  end

  describe '#play' do
    it 'checks who won the game' do
      computer_wins = @player_cruiser.sunk? && @player_sub.sunk?
      expect(computer_wins).to be false
    end
  end

  describe '#turn' do
    it "#checks miss" do
      @computer_turns = @computer_board.cells.keys
      computer_shot = "B1"
      @computer_turns.delete(computer_shot)
      expect(@computer_turns.count).to eq(15)
      player_cell = @player_board.cells["B1"]
      player_cell.fire_upon
      expect(player_cell.fired_upon?). to be true
      expect(player_cell.render).to eq("M")
    end

    it "#checks hit" do
      @player_board.place(@player_cruiser, ["B1", "B2", "B3"])
      @computer_turns = @computer_board.cells.keys
      computer_shot = "B1"
      @computer_turns.delete(computer_shot)
      expect(@computer_turns.count).to eq(15)
      player_cell = @player_board.cells["B1"]
      player_cell.fire_upon
      expect(@player_board.cells["B1"].fired_upon?).to be true
      expect(player_cell.render).to eq("H")
    end
  end
end
