require_relative 'plane'

class Airport
  def initialize(capacity = 10)
    @capacity = capacity
    @terminal = []
  end

def terminal
  @terminal
end

def land_plane(plane)
  raise("#{plane} is already at the airport") if @terminal.include?(plane)
  raise("#{plane} is not flying.") if !plane.flying
  raise("#{plane} cannot land. #{self} is at capacity.") if airport_full?
  plane.grounded
  @terminal << plane
end

def take_off(plane)
  raise("#{plane} is not at this airport") if !@terminal.include?(plane)
  @terminal.delete(plane)
  plane.in_flight
  "#{plane} has left the #{self}"
end

private
def airport_full?
  @terminal.length >= @capacity
end

end
