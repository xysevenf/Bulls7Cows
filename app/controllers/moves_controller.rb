class MovesController < ApplicationController

  def create
    move = Move.new(permitted_params.except(:cows, :bulls))
    move.result = permitted_params[:bulls].to_i * 10 + permitted_params[:cows].to_i
    if move.save
      redirect_to move.game
    else
      render plain: "#{move.errors.first}"
    end
  end

  def destroy
    move = Move.find(params[:id])
    redirect_to move.game if !move
    move.destroy
    redirect_to move.game
  end

  def permitted_params
    params.require(:move).permit(:game_id, :number, :cows, :bulls)
  end
end