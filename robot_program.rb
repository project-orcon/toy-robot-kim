Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }

grid = Grid.new(5, 5)
robot = ToyRobot.new(grid)
processor = CommandProcessor.new(robot)

puts "Enter Commands"
while(1) do
    processor.process
end