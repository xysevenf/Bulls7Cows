class StartPageController < ApplicationController
  def greeting
    @game = Game.new
  end
end
