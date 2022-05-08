require "./classes/robot_program.rb"
@program = RobotProgram.new
while(1)
    @program.process_command
end