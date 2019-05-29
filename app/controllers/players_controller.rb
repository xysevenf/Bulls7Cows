class PlayersController < ApplicationController

  def new
  end

  def create
    binding.pry
  end

  def permitted_params
    params.require([:player, :game])
    params.permit(player: [:name], game: [:difficulty])
  end
end
