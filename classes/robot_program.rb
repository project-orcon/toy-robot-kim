# frozen_string_literal: true

require_relative './grid'
require_relative './toy_robot'

class RobotProgram
  COMMANDS = %w[PLACE MOVE REPORT LEFT RIGHT].freeze
  FACES = %w[NORTH EAST SOUTH WEST].freeze
  GRID_SIZE = 5
  attr_reader :errors

  def initialize
    @toy_robot = ToyRobot.new(Grid.new(GRID_SIZE, GRID_SIZE))
    @errors = false
  end

  def process_command
    reset_errors
    command, arguments = get_input
    return unless correct_input?(command, arguments)

    execute_command(command, arguments)
  end

  private

  def reset_errors
    @errors = false
  end

  def get_input
    command_line = gets.chomp
    command = command_line.split(' ')[0]
    arguments = command_line.split(' ')[1]&.split(',')
    [command, arguments]
  end

  def correct_input?(command, arguments)
    if command == 'PLACE' && arguments.count == 3 && is_number?(arguments[0]) && is_number?(arguments[1]) && is_face?(arguments[2])
      true
    elsif COMMANDS.include?(command) && arguments.nil?
      true
    else
      @errors = true
      false
    end
  end

  def execute_command(command, arguments)
    @toy_robot.send(command.downcase, *format_arguments(arguments))
  end

  def format_arguments(arguments)
    return unless arguments.is_a?(Array)

    arguments.map { |a| is_number?(a) ? a.to_i : a }
  end

  def is_number?(string)
    true if Integer(string)
  rescue StandardError
    false
  end

  def is_face?(string)
    FACES.include?(string)
  end
end
