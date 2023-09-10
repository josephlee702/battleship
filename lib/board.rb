class Board
  attr_reader :coordinates
  def initialize
    @coordinates = {}   
  end

  def cells
    pairs = []
    letters = ["A" ,"B", "C", "D"]
    numbers = ["1","2","3","4"]
    
    numbers.each do |num|
      letters.each do |letter|
        pairs << letter + num 
      end
    end
    pairs.sort.each do |pair|
      @coordinates[pair] = Cell.new(pair)
    end
    @coordinates
  end
  
  def valid_coordinate?(coordinate)
    valid_coordinate = coordinates.keys
    if valid_coordinate.include?(coordinate)
      true
    else 
      false
    end
  end

end