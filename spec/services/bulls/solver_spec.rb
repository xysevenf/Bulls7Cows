describe Bulls::Solver do
  describe '.intialize' do
    context 'when initializing with no moves' do
      solver = Bulls::Solver.new
      it 'solver have 5040 items in potentials' do
        expect(solver.potentials.size).to be 5040
      end
    end
    context 'when initializing with one move' do
      context 'and move result is 1 cow and 1 bull' do
        moves = []
        moves << Move.new(number: 1234, cows: 1, bulls: 1)
        solver = Bulls::Solver.new(moves)
        it 'solver have 720 items in potentials' do
          expect(solver.potentials.size).to be 720
        end
      end
      context 'and move result is 4 cows 0 bulls' do
        moves = []
        moves << Move.new(number: 1234, cows: 4, bulls: 0)
        solver = Bulls::Solver.new(moves)
        it 'solver have 9 items in potentials' do
          expect(solver.potentials.size).to be 9
        end
      end
    end
  end
end