class MovesController < ApplicationController

  def create
    game = Game.find(permitted_params[:game_id])
    move = Move.new
    move.game = game
    move.player_id = 1    # change
    solver = Bulls::Solver.new(game)
    move.number = solver.next_move
    move.result = Bulls::Game.new(game).guess(move.number)
    if move.save
      redirect_to game
    else
      render json: 'Something goes wrong'
    end
  end

  def permitted_params
    params.permit(:game_id)
  end

end