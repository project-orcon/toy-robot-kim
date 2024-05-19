# frozen_string_literal: true

describe Reports::Simple do
  let(:toy_robot) { instance_double('ToyRobot', face: 'NORTH', coordinates: OpenStruct.new(x: 1, y: 2)) }
  subject { described_class.new(toy_robot) }

  describe '#report' do
    it 'reports the current position and face of the robot' do
      expect { subject.report }.to output("1,2,NORTH\n").to_stdout
    end

    it 'reports that the robot is not placed on the board' do
      allow(toy_robot).to receive(:face).and_return(nil)
      allow(toy_robot.coordinates).to receive(:x).and_return(nil)
      allow(toy_robot.coordinates).to receive(:y).and_return(nil)
      expect { subject.report }.to output("Robot not placed on board\n").to_stdout
    end
  end
end
