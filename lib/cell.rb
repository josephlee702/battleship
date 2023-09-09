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
      if flag == true
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
