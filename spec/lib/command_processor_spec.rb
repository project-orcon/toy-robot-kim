# frozen_string_literal: true

describe 'Robot Program' do
  let(:grid) { Grid.new(5,5)}
  let(:robot) { ToyRobot.new(grid)}

  subject { CommandProcessor.new(robot) }

  context 'User enters correct commands' do
    ['MOVE', 'REPORT', ' REPORT ', 'LEFT', 'RIGHT', 'PLACE 1,2,NORTH', 'PLACE 0,0,EAST', 'PLACE 0,10,WEST',
     'PLACE 5,1,SOUTH'].each do |command|
      it "does not return an error when user enters valid command #{command}" do
        subject.stub(:gets).and_return(command)
        subject.process
        expect(subject.errors).to eq false
      end
    end
  end

  context 'User enters incorrect commands' do
    ['MOVER', 'PLACE 1,2,NORF', 'PLACE CAT,0,EAST', 'PLACE 0.10,5,WEST', 'PLACE 5,1,SOUTH,BEACH'].each do |command|
      it "does not return an error when user enters valid command #{command}" do
        subject.stub(:gets).and_return(command)
        subject.process
        expect(subject.errors).to eq true
      end
    end
  end
end
