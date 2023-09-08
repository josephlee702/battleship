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
end

#attriibutes: coordinate, ship
#methods : place_ship , empty?
