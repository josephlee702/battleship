class Cell 
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def place_ship(ship)
    @ship = ship
  end

  def empty?
    @ship == nil 
  end
  
  def fire_upon
    @fired_upon = true
    @ship.hit unless @ship.nil?
  end

  def fired_upon?
    @fired_upon
  end

  def render(flag = false)
    if fired_upon?
      if empty?
        "M"
      else
        if @ship.sunk?
          "X"
        else
          "H"
        end
      end
    else
      if flag
        if @ship.nil?
          "."
        else
          "S"
        end
      else
        "."
      end
    end
  end
end

#attriibutes: health,
#methods : fired_upon?

# "." - when render is called upon a cell that has not been fired upon 
# "M" - if the cell is fired upon and there is no ship on the cell
# "H" - if the cell is fired upon and there is a ship on the cell
# "S" -
# "X" - when the ship is sunk (aka 0 health)