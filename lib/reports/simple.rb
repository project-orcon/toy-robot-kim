# frozen_string_literal: true

module Reports
  # Represents a simple reporting mechanism for the toy robot's current state.
  class Simple
    def initialize(toy_robot)
      @toy_robot = toy_robot
    end

    def report
      output = if @toy_robot.face.nil? && @toy_robot.coordinates.x.nil? && @toy_robot.coordinates.y.nil?
                 'Robot not placed on board'
               else
                 "#{@toy_robot.coordinates.x},#{@toy_robot.coordinates.y},#{@toy_robot.face}"
               end
      puts output
      output
    end
  end
end
