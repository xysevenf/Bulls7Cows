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
end
