class Plane
  def initialize(flying = true)
    @flying = flying
  end

  def flying #=(flying)
    @flying
  end

  def grounded
    @flying = false
  end

  def in_flight
    @flying = true
  end

end
