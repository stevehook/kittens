# frozen_string_literal: true

class LocationFinder
  Location = Struct.new(:coordinates, :heading)

  attr_accessor :location

  def initialize
    self.location = Location.new([0, 0], [0, 1])
  end

  def evaluate(directions)
    directions.each do |direction|
      apply_direction(direction)
    end
    location.coordinates
  end

  FORWARD = 'forward'
  LEFT = 'left'
  RIGHT = 'right'

  private

  def apply_direction(direction)
    if direction == FORWARD
      move_forward
    elsif direction == RIGHT
      turn_right
    elsif direction == LEFT
      turn_left
    end
  end

  def move_forward
    self.location = Location.new(
      [location.coordinates[0] + location.heading[0], location.coordinates[1] + location.heading[1]],
      location.heading
    )
  end

  def turn_left
    self.location = Location.new(
      location.coordinates,
      [-1 * location.heading[1], location.heading[0]]
    )
  end

  def turn_right
    self.location = Location.new(
      location.coordinates,
      [location.heading[1], -1 * location.heading[0]]
    )
  end
end
