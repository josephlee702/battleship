class Game

  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    #this is going to hold all the cells that the computer can choose from to take a shot
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

  def main_menu
    puts "Welcome to Battleship.\nEnter p to play. Enter q to quit."
    puts "---------------------------------------------------------"
    #why do we need standard input here?
    input = $stdin.gets.chomp
    if input == "p"
      game_setup
    else
      input == "q"
      return
    end
  end

  def game_setup
    computer_setup
    player_setup
    play 
  end

  #computer randomly sets up ships on his board
  def computer_setup
    @computer_turns = @computer_board.cells.keys
    random_coord = @computer_coords.sample
    cruiser_coords = random_coord[0]
    sub_coords = random_coord[1]
    @computer_board.place(@computer_cruiser, cruiser_coords)
    @computer_board.place(@computer_sub, sub_coords)
  end

  #we place our ships on the board
  def player_setup
    puts "---------------------------------------------------------"
    puts "I have laid out my ships on the grid. \nYou now need to lay out your two ships.\nThe Cruiser is three units long and the Submarine is two units long."
    @player_board.render(true)
    puts "Enter the squares for the Cruiser (3 spaces):"
    puts "ex. 'A1 A2 A3'"
    input = $stdin.gets.chomp
    until @player_board.place(@player_cruiser, input.split(" "))
      puts "Those are invalid coordinates. Please try again:"
      input = $stdin.gets.chomp
    end
    puts "Nice, you have placed your Cruiser.\nEnter the squares for the Submarine (2 spaces):"
    input = $stdin.gets.chomp
    until @player_board.place(@player_sub, input.split(" "))
      puts "Those are invalid coordinates. Please try again:"
      input = $stdin.gets.chomp
    end
  end

  def play
    computer_wins = @player_cruiser.sunk? && @player_sub.sunk?
    player_wins = @computer_cruiser.sunk? && @computer_sub.sunk?
    
    until computer_wins || player_wins
      #would be nice to display turn number every time a turn is taken here
      turn
      computer_wins = @player_cruiser.sunk? && @player_sub.sunk?
      player_wins = @computer_cruiser.sunk? && @computer_sub.sunk?
    end

    if computer_wins
      puts "---------------------------------------------------------"
      puts "I won!"
    elsif player_wins
      puts "---------------------------------------------------------"
      puts "You won!"
    else computer_wins && player_wins
      puts "It's a tie."
    end

    #GAME SUMMARY
    puts "---------------------------------------------------------"
    puts "FINAL BOARDS"
    puts "=============COMPUTER BOARD============="
    @computer_board.render(true)
    puts "==============PLAYER BOARD=============="
    @player_board.render(true)
  end

  def turn
    # print boards
    puts "---------------------------------------------------------"
    puts "=============COMPUTER BOARD============="
    @computer_board.render
    puts "==============PLAYER BOARD=============="
    @player_board.render(true)
    puts "---------------------------------------------------------"

    # player turn (player shooting on a cell)
    puts "Enter the coordinate for your shot:"
    player_shot = $stdin.gets.chomp
    #until block is accepting a valid coordinate for the player to shoot on
    until @computer_board.valid_coordinate?(player_shot) && !@computer_board.cells[player_shot].fired_upon?
      if !@player_board.valid_coordinate?(player_shot)
        puts "Please enter a valid coordinate on the map:"
      else @computer_board.cells[player_shot].fired_upon?
        puts "This shot has already been fired on. Please choose another coordinate."
      end
    player_shot = $stdin.gets.chomp
    end
    #now we get to fire upon the computer board cell
    computer_cell = @computer_board.cells[player_shot]
    computer_cell.fire_upon

    # computer turn (computer shoots on a cell)
    computer_shot = @computer_turns.sample
    @computer_turns.delete(computer_shot)
    player_cell = @player_board.cells[computer_shot]
    player_cell.fire_upon

    # results
    puts "Your #{result(computer_cell, player_shot)}"
    puts "My #{result(player_cell, computer_shot)}"
  end

  def result(cell, coordinate_fired_upon)
    if cell.render == "M"
      "shot on #{coordinate_fired_upon} was a miss"
    elsif cell.render == "H"
      "shot on #{coordinate_fired_upon} was a hit"
    else 
      "shot on #{coordinate_fired_upon} sunk the ship"
    end
  end
end
