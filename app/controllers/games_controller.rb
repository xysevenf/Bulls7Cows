class GamesController < ApplicationController

  def new
  end

  def create
    game = Game.new
    if game.save
      redirect_to game
    else
      render plain: 'Error'
    end
  end

  def show
    @game = Game.find(params[:id])
    @solver = Bulls::Solver.new(@game.moves)
    @move = Move.new
    @move.number = @solver.next_move
    @estimates = @solver.estimates
  end

  def test_average
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
    render plain: "#{results.inject { |sum, el| sum + el } / results.size.to_f }"
  end
end
