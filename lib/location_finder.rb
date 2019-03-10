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
    elsif direction == RIGHT
      turn_right
    end
  end

  def move_forward
    [0, 1].each do |n|
      self.coordinates[n] = self.coordinates[n] + self.heading[n]
    end
  end

  def turn_right
    if heading == [0, 1]
      self.heading = [1, 0]
    elsif heading == [1, 0]
      self.heading = [0, -1]
    elsif heading == [0, -1]
      self.heading = [-1, 0]
    else
      self.heading == [0, 1]
    end
  end
end
