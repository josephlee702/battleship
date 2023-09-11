class Game

  def initialize
  end

  def main_menu
    puts "Welcome to Battleship. Enter p to play, or enter q to quit."
    puts "---------------------------------------------------------"
    # input = gets.chomp
    # if input == "p"
    #   setup
    # else
    #   input == "q"
    #   return
    # end
  end

  def setup
    p "hi"
  end
end


#we're going to need a runner file to be able to actually run the game
#going to need a lot of loops (guessing this is because we have to take turns )

#methods: main menu, setup, turn, end_game