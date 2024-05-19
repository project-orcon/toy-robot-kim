# frozen_string_literal: true

RSpec.describe Reports::Simple do
  let(:toy_robot) { ToyRobot.new(Grid.new(5, 5)) }
  subject { described_class.new(toy_robot) }

  describe '#report' do
    context 'when the robot is placed on the board' do
      before { toy_robot.place(1, 2, 'NORTH')}

      it 'reports the current position and face of the robot' do
        expect { subject.report }.to output("1,2,NORTH\n").to_stdout
      end
    end

    context 'when the robot is not placed on the board' do

      it 'reports that the robot is not placed on the board' do
        expect { subject.report }.to output("Robot not placed on board\n").to_stdout
      end
    end
  end
end
