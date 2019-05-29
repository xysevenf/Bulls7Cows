class GamesController < ApplicationController

  def new
  end

  def create
    game = Game.new(permitted_params)
    game.player_id = 1
    if game.save
      render plain: 'OK'
    else
      render plain: 'Error'
    end

  end

  def permitted_params
    params.require(:game).permit(:difficulty)
  end
end
