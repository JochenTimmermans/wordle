class GameController < ApplicationController
  def index
  end

  def new_game
    game = GameService::new_game
    redirect_to action: 'play', uuid: game.uuid
  end

  def play
    @game = Game.find_by_uuid(params[:uuid])
  end

  def guess
    game = Game.find_by_uuid(params[:uuid])
    guess = params[:guess]

    guess_validation = GuessService::validate_guess(guess)
    if guess_validation[:status] == 'success'
      game.add_guess(guess)
    else
      flash[:error] = guess_validation[:message]
    end

    redirect_to action: 'play', uuid: game.uuid
  end
end
