# frozen_string_literal: true

describe CommandProcessor::Processor do
  let(:toy_robot) { instance_double('ToyRobot') }
  let(:reporter) { instance_double('Reports::Simple') }

  subject { described_class.new(toy_robot, reporter) }

  describe '#process' do
    context 'when processing PLACE command with valid arguments' do
      it 'calls place on the toy robot' do
        allow(toy_robot).to receive(:place)
        subject.process('PLACE 1,2,NORTH')
        expect(toy_robot).to have_received(:place).with(1, 2, 'NORTH')
      end
    end

    context 'when processing PLACE command with invalid arguments' do
      it 'raises an InvalidCommandError' do
        expect { subject.process('PLACE 1,2') }.to raise_error(CommandProcessor::InvalidCommandError)
        expect { subject.process('PLACE CAT,2,WEST') }.to raise_error(CommandProcessor::InvalidCommandError)
      end
    end

    context 'when processing invalid input string' do
      it 'raises an InvalidInputError' do
        expect { subject.process('THIS IS INVALID INPUT') }.to raise_error(CommandProcessor::InvalidInputError)
      end
    end

    context 'when processing command that does not exist' do
      it 'raises an InvalidCommandError' do
        expect { subject.process('JUMP') }.to raise_error(CommandProcessor::InvalidCommandError)
      end
    end

    context 'when processing MOVE command' do
      it 'calls move on the toy robot' do
        allow(toy_robot).to receive(:move)
        subject.process('MOVE')
        expect(toy_robot).to have_received(:move)
      end
    end

    context 'when processing REPORT command' do
      it 'calls report on the reporter' do
        allow(reporter).to receive(:report)
        subject.process('REPORT')
        expect(reporter).to have_received(:report)
      end
    end

    context 'when processing LEFT command' do
      it 'calls left on the toy robot' do
        allow(toy_robot).to receive(:left)
        subject.process('LEFT')
        expect(toy_robot).to have_received(:left)
      end
    end

    context 'when processing RIGHT command' do
      it 'calls right on the toy robot' do
        allow(toy_robot).to receive(:right)
        subject.process('RIGHT')
        expect(toy_robot).to have_received(:right)
      end
    end
  end
end
