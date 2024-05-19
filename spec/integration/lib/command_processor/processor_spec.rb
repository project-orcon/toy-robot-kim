# frozen_string_literal: true

RSpec.describe CommandProcessor::Processor do
  let(:toy_robot) { ToyRobot.new(Grid.new(5, 5)) }
  let(:reporter) { Reports::Simple.new(toy_robot) }
  subject { described_class.new(toy_robot, reporter) }

  describe '#process' do
    context 'when processing PLACE command with valid arguments' do
      it 'calls place on the toy robot' do
        subject.process('PLACE 1,2,NORTH')
        expect(toy_robot.coordinates.x).to eq(1)
        expect(toy_robot.coordinates.y).to eq(2)
        expect(toy_robot.face).to eq('NORTH')
      end
    end

    context 'when processing REPORT command' do
      it 'reports the current position and face of the robot' do
        subject.process('PLACE 1,2,NORTH')
        subject.process('MOVE')
        subject.process('LEFT')
        subject.process('REPORT')
        expect(reporter.report).to eq('1,3,WEST')
      end
    end

    context 'when placed at the origin facing NORTH' do
      before { subject.process('PLACE 1,2,NORTH') }

      context 'when processing MOVE command' do
        it 'calls move on the toy robot' do
          subject.process('MOVE')
          expect(toy_robot.coordinates).to have_attributes(x: 1, y: 3)
        end
      end

      context 'when processing LEFT command' do
        it 'calls left on the toy robot' do
          subject.process('LEFT')
          expect(toy_robot.face).to eq('WEST')
        end
      end

      context 'when processing RIGHT command' do
        it 'calls right on the toy robot' do
          subject.process('RIGHT')
          expect(toy_robot.face).to eq('EAST')
        end
      end
    end
  end
end
