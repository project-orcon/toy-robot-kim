describe "Grid" do
    let(:grid_size) {5}
    let(:grid) { Grid.new(grid_size, grid_size) }

    describe "valid_position?" do 
        it 'returns true when given valid coordinates' do
            expect(grid.valid_position?(0,0)).to eq true
            expect(grid.valid_position?(4,4)).to eq true
        end

        it 'returns false when given invalid coordinates' do
            expect(grid.valid_position?(3,5)).to eq false
            expect(grid.valid_position?(-1,2)).to eq false
        end
    end
end