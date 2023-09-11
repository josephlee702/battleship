class Board
  attr_reader :cells #attribute reader for the `cells` instance variable, allowing you to access the board's cells from outside the class.
  def initialize #instance variable `@cells`, which is a hash that represents the board's cells. The default value for each cell is set to `0`.
    @cells = Hash.new(0)
    build_board #calls build_board to add cells to the board
  end
  def build_board
    ('A'..'D').each do |letter| # iterates through the rows ('A' to 'D') and columns (1 to 4) and creates unique coordinates for each cell
      (1..4).each do |number|
        coordinate = "#{letter}#{number}"
        cell_default = Cell.new(coordinate) #initializes a cell with a Cell object and stores it into the @cell hash 
        @cells[coordinate] = cell_default
      end
    end
  end
  #('A'..'D').each do |letter| iterates through each row represented by 'A'- 'D' letters are used to see the letters on the board 
  #(1..4).each do |number| iteraties through numbers in each row and are used to see the numbers on the board 
  #coordinate = "#{letter}#{number}" coordinate are made by combinding the row number and letter
  #
  def valid_coordinate?(coordinate) #checks if a given coordinate is valid by verifying if it exists in the `@cells` hash
    @cells.include?(coordinate) #if coordinate in hash return true if not return false
  end

  def valid_placement?(ship, placement_coordinates) #makes sure placement of the ship is valid acoording to the rules
    if ship.length != placement_coordinates.length #checks if the length of the ship matches the number of placement coordinates if not return false
      false
    elsif occupied_cells(placement_coordinates) #checks if the coordinate is occupied by a ship, (occupied_cells) if they are occupied return false
      false
    elsif coordinate_horizontal_letters_logic(placement_coordinates) && coordinate_horizontal_numbers_logic(ship, placement_coordinates) || coordinate_vertical_number_logic(placement_coordinates) && coordinate_verticle_letter_logic(ship, placement_coordinates) #checks if they are horizontal or vertical if they do true if not false
      true
    else false
    end
  end

  def coordinate_horizontal_letters_logic(placement_coordinates) 
    letters = placement_coordinates.map do |coordinate| 
    coordinate[0]
    end
    letters.uniq.length == 1
  end

  def coordinate_horizontal_numbers_logic(ship, placement_coordinates) # takes two arguments: ship, which represents the ship to be placed, and placement_coordinates, which is an array of placement coordinates("A1","A2")# numbers to store the extracted number parts of the coordinates.#uses the map method to iterate through each coordinate in the placement_coordinates array.
    numbers = placement_coordinates.map do |coordinate| #extracts the second character (the number part) using coordinate[1] converts the number part into an integer. Integers are stored in the numbers array.
      coordinate[1].to_i #numbers == (numbers.min..numbers.max).to_a checks if the numbers array contains a consecutive range of integers.#(numbers.min..numbers.max) - creates a range of integers from the minimum to the maximum value in the numbers array. example numbers(array) = [1,2,3], the range is [1..3]
    end# .to_a converts this range into an array. for [1, 2, 3], this part becomes [1, 2, 3]- compares this array to the numbers array. If the numbers array contains consecutive numbers, this condition evaluates to true
    numbers == (numbers.min..numbers.max).to_a && numbers.length == ship.length #numbers.length == ship.length- checks if the number of elements in the numbers array is equal to the length of the ship, makes sure that the number of coordinates matches the length of the ship
  end #returns true if both conditions are met, indicating that the placement is valid based on horizontal number logic. if not then it will return false which means that the placement is not valid
  
  def coordinate_vertical_number_logic(placement_coordinates)# takes one argument, placement_coordinates, which is an array of placement coordinates("A1",'A2') for a ships vertical placement
    numbers = placement_coordinates.map do |coordinate| # empty array called numbers to store the extracted number parts of the coordinates.#map method to iterate through each coordinate in the placement_coordinates array.# processes each coordinate in the placement_coordinates array and extracts the second character (the number part) using coordinate[1]
    coordinate[1].to_i #converts this character into an integer using .to_i,resulting integers (representing the row numbers) are stored in the numbers. Example placement_coordinates = ["A2", "B4", "C3", "D1"] coordinate[1] extracts the second character, looks like coordinate "A2," it extracts "2." then uses .to_i to be integer 2. when all coordinates are proccessed numbers array will look like number = [2,4,3,1]
    end
    numbers.uniq.length == 1 #checks if the number of unique row numbers in the numbers array is equal to 1 #number.uniq - returns an array containing only the unique integers from the original numbers array. It removes any duplicate row numbers. #if only one unique row number, this condition evaluates to true, indicating that all the coordinates share the same row number,which means its valid vertical placement
  end #if more then one unique row, condition will be false because coordinates have diffrent row numbers which is is not valid of a vertical placement 

  def coordinate_verticle_letter_logic(ship, placement_coordinates)#takes two arguments ship, which represents a ship, and placement_coordinates, which is a list of vertical placement coordinates for that ship.
    letters = placement_coordinates.map do |coordinate| #placement_coordinates an array of strings, where each string represents a coordinate # map iterates through each element of the array and creates a new array,  #creates a new array called letters #iterates through each element in the placement_coordinates list where each element is a coordinate 
      coordinate[0].ord#ach coordinate, coordinate[0].ord is executed. This means it takes the first character of the coordinate (the letter part) using coordinate[0] and then uses .ord to convert that letter character into its corresponding ASCII code. ASCII = character encoding standard that assigns a unique numerical value which is an iteger.
    end #for example if the p_coordinates =["A1", "B2","C3"] .map would iterate through each coordinate in the P_coordinate array. Takes the first charcter of the coordinate using coordinate[0]. Example in 'A1' it will take the "A" out in ASCII code "A" = 65. 65 then becomes the result for that specific coordinate in the new array generated by .map # after processing the first coordinate "A1," the letters array will have one element, which is 65. 
    letters == (letters.min..letters.max).to_a && letters.length == ship.length #letters.min finds the minimum ASCII code value in the letters array. for example [65,66,67] letter.min =65.#letter.max finds max in letters array
  end #(letters.min..letters.max).to_a - creates an array of consecutive ASCII codes from the minimum to the maximum ASCII code found in the letters array
  #letters == (letters.min..letters.max).to_a - This checks if the letters array is equal to the array of consecutive ASCII codes, makes sure ASCII codes are contgous if they do = true
  #letters.length-retrieves the number of elements (ASCII codes) in the letters array tells us how many ASCII codes there are. #ship.length -retrieves the length of the ship.
  #letters.length == ship.length - checks if the number of elements in the letters array is equal to the length of the ship,  verifies if the number of coordinates in the letters array matches the expected length of the ship
  #first condition letters == (letters.min..letters.max).to_a checks that the ASCII codes form a contiguous range, making sure that the placement is vertical and consecutive . #second condition = letters.length == ship.length) checks that the number of coordinates matches the ship's length.

  def place(ship, placement_coordinates)  #places a ship on the board by marking the corresponding cells as filled with the type of ship.generates an array representing a contiguous range of ASCII codes.Example =  if letters is [65, 66, 67], this part produces [65, 66, 67], as these are consecutive ASCII codes for 'A', 'B', and 'C'.
    placement_coordinates.each do |new_coordinate|
      @cells[new_coordinate].place_ship(ship)
    end
  end

  def occupied_cells(placement_coordinates) #checks coordinates are occupied by a ship 
    placement_coordinates.each do |new_coordinate| #Returns ship object if cell is filled or "nil" if they are not filled up
      return @cells[new_coordinate].ship
    end
  end

  def render(user = false) #takes an optional argument user, which is set to false by default.
    puts "  1 2 3 4" #displays the column headers "1 2 3 4" at the top of the game board.
  
    ('A'..'D').each do |letter| # line starts a loop that iterates through each row, represented by the letters 'A' to 'D'.
      letter_cells = [] #letter_cells to store the contents of the cells in the current row.
  
      (1..4).each do |number|  #starts another loop that iterates through each column, represented by the numbers 1 to 4 in the row 
        coordinate = "#{letter}#{number}" #onstructs the coordinate for the current cell by combining the current row letter and number for example in the #{letter} would go letter A and in the #{number} number 1 goes into it 
  
        if user == true
          cell_content = @cells[coordinate].render(true) #calls render method coordinate passing true which will reveal the contnet 
        else
          cell_content = @cells[coordinate].render #this does not call the method which hides the content
        end
  
        letter_cells << cell_content #add the call content to the letter_cells array for the row its on 
      end
  
      row_string = "#{letter} #{letter_cells.join(' ')}" ##{letter} is a placeholder that gets replaced with the current letter #letters ('A','B','C')
      puts row_string #.join(' ')- takes each element of the letter_cells array, adds a space between them, and combines them into one string
    end
  end
end


