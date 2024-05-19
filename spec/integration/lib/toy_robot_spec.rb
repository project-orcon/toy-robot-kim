# frozen_string_literal: true

RSpec.describe ToyRobot do
  let(:grid) { Grid.new(5, 5) }
  subject { described_class.new(grid) }

  shared_examples 'changes direction correctly' do |commands, expected_face|
    it "faces #{expected_face}" do
      commands.each { |command| subject.send(command) }

      expect(subject.face).to eq expected_face
    end
  end

  context 'when placed at the origin facing NORTH' do
    before { subject.place(0, 0, 'NORTH') }

    context 'when turning' do
      include_examples 'changes direction correctly', %i[left], 'WEST'
      include_examples 'changes direction correctly', %i[left left], 'SOUTH'
      include_examples 'changes direction correctly', %i[left left left], 'EAST'
      include_examples 'changes direction correctly', %i[left left left left], 'NORTH'
      include_examples 'changes direction correctly', %i[right], 'EAST'
      include_examples 'changes direction correctly', %i[right right], 'SOUTH'
      include_examples 'changes direction correctly', %i[right right right], 'WEST'
      include_examples 'changes direction correctly', %i[right right right right], 'NORTH'
    end

    context 'when moving' do
      it 'moves one square up' do
        subject.move
        expect(subject.coordinates).to have_attributes(x: 0, y: 1)
      end

      it 'moves back to its original position with move and right twice' do
        subject.move
        subject.right
        subject.right
        subject.move
        expect(subject.coordinates).to have_attributes(x: 0, y: 0)
      end

      it 'moves one square to the right' do
        subject.right
        subject.move
        expect(subject.coordinates).to have_attributes(x: 1, y: 0)
      end

      it 'moves back to original position with right, move, left twice, move' do
        subject.right
        subject.move
        subject.left
        subject.left
        subject.move
        expect(subject.coordinates).to have_attributes(x: 0, y: 0)
      end
    end

    context 'when placing at different coordinates' do
      it 'is placed at (4,4) facing SOUTH' do
        subject.place(4, 4, 'SOUTH')
        expect(subject.coordinates).to have_attributes(x: 4, y: 4)
        expect(subject.face).to eq 'SOUTH'
      end
    end

    context 'when given invalid moves' do
      it 'does not change position with right twice, move' do
        subject.right
        subject.right
        subject.move
        expect(subject.coordinates).to have_attributes(x: 0, y: 0)
      end

      it 'does not change position with left, move' do
        subject.left
        subject.move
        expect(subject.coordinates).to have_attributes(x: 0, y: 0)
      end
    end
  end

  context 'when not placed' do
    it 'does not face any direction with right' do
      subject.right
      expect(subject.face).to be_nil
    end

    it 'does not face any direction with left' do
      subject.left
      expect(subject.face).to be_nil
    end

    it 'does not have a position on the grid with move' do
      subject.move
      expect(subject.coordinates).to have_attributes(x: nil, y: nil)
    end
  end
end
