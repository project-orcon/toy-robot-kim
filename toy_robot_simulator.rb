# frozen_string_literal: true

require 'require_all'
require 'logger'
# Load all Ruby files in the 'lib' directory and its subdirectories
require_all 'lib'

class ToyRobotSimulator
  GRID_SIZE = 5
  LOG_FILE_PATH = './toy_robot_simulator.log'

  def initialize
    @grid = Grid.new(GRID_SIZE, GRID_SIZE)
    @robot = ToyRobot.new(@grid)
    @reporter = Reports::Simple.new(@robot)
    @processor = CommandProcessor::Processor.new(@robot, @reporter)
    @logger = Logger.new(LOG_FILE_PATH)
  end

  def start
    puts 'Enter Commands'
    loop do
      input = gets.chomp
      process_input(input)
    end
  end

  private

  def process_input(input)
    @processor.process(input)
  rescue CommandProcessor::InvalidInputError => e
    log_error("CommandProcessor: #{e.message}")
  rescue CommandProcessor::InvalidCommandError => e
    log_error("CommandProcessor: #{e.message}")
  rescue StandardError => e
    log_error("An error occurred: #{e.message}")
  end

  def log_error(message)
    @logger.error(message)
    puts "Error: #{message}"
  end
end

ToyRobotSimulator.new.start if __FILE__ == $PROGRAM_NAME
