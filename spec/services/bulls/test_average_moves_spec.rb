RSpec.describe 'Bulls::Solver', :no_auto => true do
  context 'if we run solver for 1000 games' do
    it 'solves all games for' do
      repeat = 1000
      results = []
      move_struct = Struct.new(:number, :result)
      repeat.times do
        game = Bulls::Game.new
        moves = []
        solver = Bulls::Solver.new(moves)
        move = move_struct.new
        until move.result == 40 do
          move = move_struct.new
          move.number = solver.next_move
          move.result = game.bulls_cows(move.number)
          moves << move
          solver.reduce_potentials_last
        end
        results << moves.size
      end
      p "Average moves to solve: #{results.inject { |sum, el| sum + el } / results.size.to_f }"
    end
  end
end