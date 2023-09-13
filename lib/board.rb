class Board
  attr_reader :cells

  def initialize
    @cells = Hash.new(0)
    build_board 
  end

  def build_board
    ('A'..'D').each do |letter| 
      (1..4).each do |number|
        coordinate = "#{letter}#{number}" 
        cell_default = Cell.new(coordinate) 
        @cells[coordinate] = cell_default
      end
    end
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate) 
  end

  def valid_coordinates?(coordinates)
    coordinates.each do |coordinate|
      if !valid_coordinate?(coordinate)
        return false
      end
    end
    true
  end

  def valid_placement?(ship, placement_coordinates)
    if ship.length != placement_coordinates.length
      false
    elsif !valid_coordinates?(placement_coordinates)
      false
    elsif occupied_cells(placement_coordinates)
      false
    elsif coordinate_horizontal_letters_logic(placement_coordinates) && coordinate_horizontal_numbers_logic(ship, placement_coordinates) || coordinate_vertical_number_logic(placement_coordinates) && coordinate_verticle_letter_logic(ship, placement_coordinates)
      true 
    else 
      false
    end 
  end

  def coordinate_horizontal_letters_logic(placement_coordinates) 
    letters = placement_coordinates.map do |coordinate| 
      coordinate[0] 
    end
    letters.uniq.length == 1 
  end 

  def coordinate_horizontal_numbers_logic(ship, placement_coordinates)
    numbers = placement_coordinates.map do |coordinate| 
      coordinate[1].to_i
    end
    numbers == (numbers.min..numbers.max).to_a && numbers.length == ship.length 
  end 
  
  def coordinate_vertical_number_logic(placement_coordinates)#
    numbers = placement_coordinates.map do |coordinate| 
      coordinate[1].to_i 
    end
    numbers.uniq.length == 1 
  end 

  def coordinate_verticle_letter_logic(ship, placement_coordinates)
    letters = placement_coordinates.map do |coordinate| 
      coordinate[0].ord
    end  
    letters == (letters.min..letters.max).to_a && letters.length == ship.length 
  end 

  def occupied_cells(placement_coordinates) 
    placement_coordinates.each do |coordinate| 
      if @cells[coordinate].ship
        return true
      end
    end
    false 
  end

  def place(ship, placement_coordinates)
    if valid_placement?(ship, placement_coordinates)
      placement_coordinates.each do |new_coordinate| 
        @cells[new_coordinate].place_ship(ship) 
      end
      return true
    else
      return false
    end
  end

  def render(user = false)
    puts "  1 2 3 4" 
    ('A'..'D').each do |letter| 
      letter_cells = [] 
      (1..4).each do |number|  
        coordinate = "#{letter}#{number}" 
        if user == true
          cell_content = @cells[coordinate].render(true) 
        else
          cell_content = @cells[coordinate].render 
        end
        letter_cells << cell_content 
      end
      
      row_string = "#{letter} #{letter_cells.join(' ')}" 
      puts row_string
    end
  end
end