class Board
  attr_reader :cells #attribute reader for the `cells` instance variable, allowing you to access the board's cells from outside the class.

  def initialize #instance variable `@cells`, which is a hash that represents the board's cells. The default value for each cell is set to `0`.
    @cells = Hash.new(0)
    build_board #calls build_board to add cells to the board
  end

  def build_board
    ('A'..'D').each do |letter| #starts an outer loop that iterates through the rows of the board. It uses the range ('A'..'D')  loop assigns the current row letter to the variable letter
      (1..4).each do |number|#starts an inner loop that iterates through the columns of the board. It uses the range (1..4) - loop assigns the current column number to the variable number.
        coordinate = "#{letter}#{number}" #combines the current letter and number to create a unique coordinate for the current cell. Example:  if letter is 'A' and number is 1, it creates the coordinate 'A1'
        cell_default = Cell.new(coordinate) #initializes a new cell object using the Cell class, passing the coordinate as an argument. Creates a cell for the coordinate
        @cells[coordinate] = cell_default #stores the cell object (cell_default) into the @cells hash using the coordinate as the key. This way it has @cells populated with cell onject representing each coordinate 
      end
    end
  end
  #('A'..'D').each do |letter| iterates through each row represented by 'A'- 'D' letters are used to see the letters on the board 
  #(1..4).each do |number| iteraties through numbers in each row and are used to see the numbers on the board 
  #coordinate = "#{letter}#{number}" coordinate are made by combinding the row number and letter

  def valid_coordinate?(coordinate) #checks if a given coordinate is valid by verifying if it exists in the `@cells` hash
    @cells.include?(coordinate) #if coordinate in hash return true if not return false
  end

  def valid_placement?(ship, placement_coordinates) #takes two arguments: ship (representing the ship being placed) and placement_coordinates (representing the coordinates where the ship is being placed).
    if ship.length != placement_coordinates.length #hecks if the length of the ship (the number of cells it occupies) is not equal to the number of placement coordinates provided. If they are not equal, it means the ship cannot fit into the specified coordinates, and the method returns false
      false
    elsif occupied_cells(placement_coordinates) #checks if any of the coordinates in placement_coordinates are already occupied by another ship using the coccupied method. If cells are occupied this mean the placement is invalid and will be false 
      false
    elsif coordinate_horizontal_letters_logic(placement_coordinates) && coordinate_horizontal_numbers_logic(ship, placement_coordinates) || coordinate_vertical_number_logic(placement_coordinates) && coordinate_verticle_letter_logic(ship, placement_coordinates)
      true #method checks if the placement coordinates are aligned horizontally# coordinate horizontal number logic checks if the placement coordinates are consecutive numbers and have the same length as the ship.# coordinate_vertical_number_logic(placement_coordinates) checks if the placement coordinates are aligned vertically 
    else false ##coordinate_verticle_letter_logic(ship, placement_coordinates)checks if the placement coordinates are consecutive letters and have the same length as the ship. If all of these conditions are met the placement is valid but if none of the conditions are met then placement id false
    end #Example placement_coordinates represent a horizontal placement with consecutive numbers and the correct ship length, meeting the conditions checked by coordinate_horizontal_letters_logic and coordinate_horizontal_numbers_logic would return true if all condtions are met
  end

  def coordinate_horizontal_letters_logic(placement_coordinates) #takes an argument 
    letters = placement_coordinates.map do |coordinate| #letters = store an array of letters that represent the horizontal coordinates #starts an iteration over each coordinate in the placement_coordinates array. each coordinate is a string like "A1" "B2" code will be applied to each coordinate
    coordinate[0] #example placement_coordinates is ["A1", "A2", "A3"] then comes in coordinate[0] which would extract the letter "A" from the coordinate  
    end
    letters.uniq.length == 1 #unique removes duplicates in the letter array, before .uniq = ["A","A", "A"] and after uniq["A"]
  end # The .length == 1 means that all the coordinates had the same letter, indicating that the placement is horizontal, as all the coordinates share the same row. if coordinates are not equal to 1 this means its not horizontal# Exmaple ["A"], the length is 1, so the condition letters.uniq.length == 1 evaluates to true # Example that does not collow this array ["A", "B"], the length is not 1, so the condition letters.uniq.length == 1 evaluates to false,

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
    placement_coordinates.each do |new_coordinate| #two arguments: ship (representing the ship to be placed) and placement_coordinates (representing the coordinates where the ship will be placed)
      @cells[new_coordinate].place_ship(ship) #line begins an iteration through each coordinate in the placement_coordinates array
    end # @cells[new_coordinate].place_ship(ship): This line accesses the @cells hash using the new_coordinate as the key. I
  end# @cells[new_coordinate] accesses the cell object associated with the new_coordinate on the game board. #.place_ship(ship) is a method from the cell object

  def occupied_cells(placement_coordinates) # one argument: placement_coordinates, which is an array of coordinates to check.
    placement_coordinates.each do |new_coordinate| #starts an iteration through each coordinate in the placement_coordinates array.
      return @cells[new_coordinate].ship #accesses the @cells hash using new_coordinate as the key #@cells[new_coordinate] accesses the cell object associated with the new_coordinate on the game board.ship - retrieves the ship object associated with the cell. if empty it will return nil
    end
  end

  def render(user = false) #takes an optional argument user, which is set to false by default.
    puts "  1 2 3 4" #displays the column headers "1 2 3 4" at the top of the game board.
  
    ('A'..'D').each do |letter| # line starts a loop that iterates through each row, represented by the letters 'A' to 'D'.
      letter_cells = [] #letter_cells to store the contents of the cells in the current row.
  
      (1..4).each do |number|  #starts another loop that iterates through each column, represented by the numbers 1 to 4 in the row 
        coordinate = "#{letter}#{number}" #onstructs the coordinate for the current cell by combining the current row letter and number for example in the #{letter} would go letter A and in the #{number} number 1 goes into it 
  
      #SEE IF WE CAN WRITE A HELPER METHOD / REFACTOR FOR THIS
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

       
