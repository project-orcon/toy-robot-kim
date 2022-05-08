
require_relative './grid.rb'
require_relative './toy_robot.rb'

class RobotProgram
    COMMANDS = ["PLACE", "MOVE", "REPORT", "LEFT", "RIGHT"].freeze
    FACES = ['NORTH','EAST','SOUTH', 'WEST'].freeze
    
    def initialize
        @toy_robot = ToyRobot.new(Grid.new(5,5))
    end

    def process_command
        command,arguments = get_input
        return "Incorrect command or arguments" unless correct_input?(command,arguments)
        if arguments.nil?
            @toy_robot.send(command.downcase)
        else
            @toy_robot.send(command.downcase, *format_arguments(arguments))
        end
    end

    private

    def get_input
        puts "Enter Command"
        command_line = gets.chomp
        command =  command_line.split(" ")[0]
        arguments =  command_line.split(" ")[1]&.split(",")
        return command,arguments
    end

    def correct_input?(command,arguments)
        if arguments.nil?
            COMMANDS.include?(command)
        else
            COMMANDS.include?(command) && is_number?(arguments[0]) && is_number?(arguments[1]) && is_face?(arguments[2])
        end
    end

    def format_arguments(arguments)
        arguments.map{|a| is_number?(a) ? a.to_i : a}
    end

    def is_number? string
        true if Float(string) rescue false
    end

    def is_face? string
        FACES.include?(string)
    end
      
end