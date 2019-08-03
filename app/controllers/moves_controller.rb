class MovesController < ApplicationController

  def create
    @move = Move.new(permitted_params)
    @move.bulls = 0 if @move.bulls.nil?
    @move.cows = 0 if @move.cows.nil?
    if @move.save
      redirect_to @move.game
    else
      @game = Game.find(@move.game_id)
      @solver = Bulls::Solver.new(@game.moves)
      @last_move = @game.moves.last
      render 'games/show'
    end
  end

  def destroy
    move = Move.find(params[:id])
    redirect_to move.game if !move
    move.destroy
    redirect_to move.game
  end

  private

  def permitted_params
    params.require(:move).permit(:game_id, :number, :cows, :bulls)
  end
end