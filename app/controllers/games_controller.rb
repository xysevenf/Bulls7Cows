class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    game = Game.new(permitted_params)
    game.player_id = 1
    bulls = Bulls::Game.new(game)
    game.number = bulls.secret
    if game.save
      redirect_to game
    else
      render plain: 'Error'
    end
  end

  def show
    @game = Game.find(params[:id])
    @solver = Bulls::Solver.new(@game)
  end

  def test_average
    repeat = 30
    results = []
    repeat.times do
      game = Bulls.Game.new
      game.secret
      solver = Bulls::Solver.new(game)
      res = 0
      until res != 40 do
        game.moves << solver.next_move
        res = game.guess(game.moves.last)
        solver.reduce_potentials
      end

      result << moves_counter
    end

    render plain: "#{result.inject { |sum, el| sum + el } / result.size }"
  end

  def permitted_params
    params.require(:game).permit(:difficulty)
  end
end
