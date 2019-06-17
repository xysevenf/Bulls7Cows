class MovesController < ApplicationController

  def create
    move = Move.new(permitted_params)
    if move.save
      redirect_to move.game
    else
      render plain: "#{move.errors.first}"
    end
  end

  def permitted_params
    params.require(:move).permit(:game_id, :number, :result)
  end

end