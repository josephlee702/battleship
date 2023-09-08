class Ship 
  attr_reader :name, :length, :health

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end

  def sunk?(ship)
    if ship.health == 0
      true
    else 
      false
    end
  end
end

#attributes: name, length, health, sunk?