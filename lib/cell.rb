class Cell 
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
  end

  def place_ship(ship)
    @ship = ship

  end

  def empty?
    if ship == nil 
      true 
    else 
      false
    end
  end
  
  def fire_upon
    if empty? == false
      ship.hit
    else 
      "This square does not have a ship"
    end
  end

  def fired_upon?
    if ship.health == ship.length
      false 
    else 
      true
    end
  end
end

#attriibutes: health,
#methods : fired_upon?