# frozen_string_literal: true

class LocationFinder
  attr_accessor :coordinates, :heading, :directions

  def initialize
    self.heading = [0, 1]
    self.coordinates = [0, 0]
  end

  def evaluate(directions)
    directions.each do |direction|
      apply_direction(direction)
    end
    coordinates
  end

  FORWARD = 'forward'
  LEFT = 'left'
  RIGHT = 'right'

  private

  def apply_direction(direction)
    if direction == FORWARD
      move_forward
    end
  end

  def move_forward
    [0, 1].each do |n|
      self.coordinates[n] = self.coordinates[n] + self.heading[n]
    end
  end
end
