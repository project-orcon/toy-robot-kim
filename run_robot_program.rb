require "./classes/robot_program.rb"
@program = RobotProgram.new
puts "Enter Commands"
while(1) do
    @program.process_command
end