# frozen_string_literal: true

describe 'Toy Robot' do
  let(:grid_size) { 5 }
  subject { ToyRobot.new(Grid.new(grid_size, grid_size)) }

  context 'is placed at the origin facing NORTH' do
    before do
      subject.place(0, 0, 'NORTH')
    end

    context 'given command/s' do
      it 'left: will face west' do
        subject.left
        expect(subject.face).to eq 'WEST'
      end

      it 'left twice: will face south' do
        subject.left
        subject.left
        expect(subject.face).to eq 'SOUTH'
      end

      it 'left three times: will face east' do
        subject.left
        subject.left
        subject.left
        expect(subject.face).to eq 'EAST'
      end

      it 'left four times: will face NORTH' do
        subject.left
        subject.left
        subject.left
        subject.left
        expect(subject.face).to eq 'NORTH'
      end

      it 'right: will face east' do
        subject.right
        expect(subject.face).to eq 'EAST'
      end

      it 'right twice: will face south' do
        subject.right
        subject.right
        expect(subject.face).to eq 'SOUTH'
      end

      it 'right three times: will face west' do
        subject.right
        subject.right
        subject.right
        expect(subject.face).to eq 'WEST'
      end

      it 'right three times: will face north' do
        subject.right
        subject.right
        subject.right
        subject.right
        expect(subject.face).to eq 'NORTH'
      end

      it 'move: moves one square up' do
        subject.move
        expect(subject.coordinates.x).to eq 0
        expect(subject.coordinates.y).to eq 1
      end

      it 'move, right twice, move: moves back to its original position' do
        subject.move
        subject.right
        subject.right
        subject.move
        expect(subject.coordinates.x).to eq 0
        expect(subject.coordinates.y).to eq 0
      end

      it 'right: moves one square to the right' do
        subject.right
        subject.move
        expect(subject.coordinates.x).to eq 1
        expect(subject.coordinates.y).to eq 0
      end

      it 'right, move, left twice, move: moves back to original position' do
        subject.right
        subject.move
        subject.left
        subject.left
        subject.move
        expect(subject.coordinates.x).to eq 0
        expect(subject.coordinates.y).to eq 0
      end

      it 'place(4,4,SOUTH): is placed at coordinates(4,4) facing south' do
        subject.place(4, 4, 'SOUTH')
        expect(subject.coordinates.x).to eq 4
        expect(subject.coordinates.y).to eq 4
        expect(subject.face).to eq 'SOUTH'
      end

      it 'reports its position as 0,0,NORTH' do
        expect(subject.report).to eq '0,0,NORTH'
      end
    end

    context 'given command/s with invalid moves,' do
      it 'right twice, move: position does not change' do
        subject.right
        subject.right
        subject.move
        expect(subject.coordinates.x).to eq 0
        expect(subject.coordinates.y).to eq 0
      end

      it 'left, move: position does not change' do
        subject.left
        subject.move
        expect(subject.coordinates.x).to eq 0
        expect(subject.coordinates.y).to eq 0
      end
    end
  end

  context 'has not been placed' do
    context 'given command/s' do
      it 'right: does not face any direction' do
        subject.right
        expect(subject.face).to eq(nil)
      end

      it 'left: does not face any direction' do
        subject.left
        expect(subject.face).to eq(nil)
      end

      it 'move: does not have a position on grid' do
        subject.move
        expect(subject.coordinates.x).to eq(nil)
        expect(subject.coordinates.y).to eq(nil)
      end

      it 'report: it returns Robot not placed on board' do
        expect(subject.report).to eq 'Robot not placed on board'
      end
    end
  end
end
