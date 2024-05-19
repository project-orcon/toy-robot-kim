# frozen_string_literal: true

# Represents a grid on which the toy robot can move.
class Grid
  def initialize(width, height)
    @x_positions = 0..width - 1
    @y_positions = 0..height - 1
  end

  def valid_position?(x, y)
    return true if @x_positions.member?(x) && @y_positions.member?(y)

    false
  end
end
