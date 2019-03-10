# frozen_string_literal: true

class LocationFinder
  Location = Struct.new(:coordinates, :heading)

  FORWARD = 'forward'
  LEFT = 'left'
  RIGHT = 'right'
  INITIAL_LOCATION = Location.new([0, 0], [0, 1])

  def evaluate(directions)
    location = directions.inject(INITIAL_LOCATION) do |current_location, direction|
      apply_direction(direction, current_location)
    end
    location.coordinates
  end

  def apply_direction(direction, location)
    if direction == FORWARD
      move_forward(location)
    elsif direction == RIGHT
      turn_right(location)
    elsif direction == LEFT
      turn_left(location)
    end
  end

  def move_forward(location)
    Location.new(
      [location.coordinates[0] + location.heading[0], location.coordinates[1] + location.heading[1]],
      location.heading
    )
  end

  def turn_left(location)
    Location.new(
      location.coordinates,
      [-1 * location.heading[1], location.heading[0]]
    )
  end

  def turn_right(location)
    Location.new(
      location.coordinates,
      [location.heading[1], -1 * location.heading[0]]
    )
  end
end
