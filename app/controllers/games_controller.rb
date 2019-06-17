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
  end

  def test_average
    repeat = 1000
    results = []
    move_class = Struct.new(:number, :result)
    repeat.times do
      game = Bulls::Game.new
      moves = []
      solver = Bulls::Solver.new(moves)
      move = move_class.new
      until move.result == 40 do
        move = move_class.new
        move.number = solver.next_move
        move.result = game.guess(move.number)
        moves << move
        solver.reduce_potentials_one
      end
      results << moves.size
    end
    render plain: "#{results.inject { |sum, el| sum + el } / results.size.to_f }"
  end
end
