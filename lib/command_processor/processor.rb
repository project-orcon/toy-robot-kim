# frozen_string_literal: true

module CommandProcessor
  # Processes commands for controlling the toy robot.
  class Processor
    COMMANDS = %w[PLACE MOVE REPORT LEFT RIGHT].freeze
    PLACE_COMMAND = 'PLACE'
    REPORT_COMMAND = 'REPORT'

    def initialize(toy_robot, reporter)
      @toy_robot = toy_robot
      @reporter = reporter
    end

    def process(input_string)
      validate_input_string(input_string)
      command, arguments = extract_data(input_string)
      validate_command(command, arguments)
      execute_command(command, arguments)
    end

    private

    def validate_input_string(input_string)
      return if valid_input_format?(input_string)

      raise CommandProcessor::InvalidInputError, "Invalid input string #{input_string}."
    end

    def valid_input_format?(input_string)
      # Regular expression to match a command followed by a list of comma separated arguments (optional)'
      /^\w+\s*(\w+(,\w+)*)?$/.match?(input_string)
    end

    def extract_data(input_string)
      parts = input_string.split(' ', 2)
      command = parts[0]
      arguments = parts[1]&.split(',')
      [command, arguments]
    end

    def validate_command(command, arguments)
      if command == PLACE_COMMAND
        validate_place_command(arguments)
      else
        validate_simple_command(command, arguments)
      end
    end

    def validate_place_command(arguments)
      if arguments && arguments.count == 3 && number_string?(arguments[0]) && number_string?(arguments[1]) && is_face?(arguments[2])
        return
      end

      raise CommandProcessor::InvalidCommandError, "Invalid PLACE command arguments: #{arguments}"
    end

    def validate_simple_command(command, arguments)
      return if COMMANDS.include?(command) && arguments.nil?

      raise CommandProcessor::InvalidCommandError, "Invalid command '#{command}' with arguments: '#{arguments}'"
    end

    def execute_command(command, arguments)
      if command == REPORT_COMMAND
        @reporter.report
      else
        @toy_robot.send(command.downcase, *format_arguments(arguments))
      end
    end

    def format_arguments(arguments)
      return unless arguments.is_a?(Array)

      arguments.map { |a| number_string?(a) ? a.to_i : a }
    end

    def number_string?(string)
      true if Integer(string)
    rescue StandardError
      false
    end

    def is_face?(string)
      ToyRobot::FACES.include?(string)
    end
  end
end
