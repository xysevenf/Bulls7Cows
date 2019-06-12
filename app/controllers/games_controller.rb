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

  def permitted_params
    params.require(:game).permit(:difficulty, )
  end
end
