class GameController < ApplicationController
  def index
  end

  def new_game
    game = GameService::new_game
    redirect_to action: 'play', uuid: game.uuid
  end

  def play
    # @game = Game.find_by_uuid(params[:uuid])
  end
end
