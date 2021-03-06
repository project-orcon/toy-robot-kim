# frozen_string_literal: true

require 'ostruct'
class ToyRobot
  FACES = %w[NORTH EAST SOUTH WEST].freeze

  attr_accessor :coordinates, :face

  def initialize(grid)
    @grid = grid
    @placed = false
    @face = nil
    @coordinates = OpenStruct.new
    @coordinates.x = nil
    @coordinates.y = nil
  end

  def left
    return unless @placed

    @face = FACES.index(@face).zero? ? 'WEST' : FACES[FACES.index(@face) - 1]
  end

  def right
    return unless @placed

    @face = FACES.index(@face) == 3 ? 'NORTH' : FACES[FACES.index(@face) + 1]
  end

  def place(x, y, face)
    if @grid.valid_position?(x, y) && FACES.include?(face)
      @coordinates.x = x
      @coordinates.y = y
      @face = face
      @placed = true
    end
  end

  def move
    return unless @placed

    next_coordinates = get_next_coordinates
    set_next_coordinates(next_coordinates)
  end

  def report
    output = if @face.nil? && @coordinates.x.nil? && @coordinates.y.nil?
               'Robot not placed on board'
             else
               "#{@coordinates.x},#{@coordinates.y},#{@face}"
             end
    puts output
    output
  end

  private

  def get_next_coordinates
    next_coordinates = OpenStruct.new
    case @face
    when 'NORTH'
      next_coordinates.x = @coordinates.x
      next_coordinates.y = @coordinates.y + 1
    when 'EAST'
      next_coordinates.x = @coordinates.x + 1
      next_coordinates.y = @coordinates.y
    when 'SOUTH'
      next_coordinates.x = @coordinates.x
      next_coordinates.y = @coordinates.y - 1
    when 'WEST'
      next_coordinates.x = @coordinates.x - 1
      next_coordinates.y = @coordinates.y
    end
    next_coordinates
  end

  def set_next_coordinates(next_coordinates)
    if @grid.valid_position?(next_coordinates.x, next_coordinates.y)
      @coordinates.x = next_coordinates.x
      @coordinates.y = next_coordinates.y
    end
  end
end
