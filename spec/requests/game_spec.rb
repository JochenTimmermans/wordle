require 'rails_helper'

RSpec.describe "Game requests", :type => :request do

  let!(:word) {
    Word.create(word: "tests")
  }

  context '/' do

    it 'shows the Wordle title' do
      get '/'
      expect(response).to render_template(:index)
      expect(response.body).to include('<h1>Wordle</h1>')
      expect(response.body).to include('Play Wordle')
    end

  end

  context 'GET /play' do

    it 'redirects to a fresh game if not provided with a uuid' do
      get '/play'
      game = Game.all.first
      expect(response).to redirect_to "/play/#{game.uuid}"
    end

    it 'redirects to a fresh game if not provided with a uuid' do
      game = GameService::new_game

      get "/play/#{game.uuid}"

      # expect(response.body).to_not include game.word.word
      expect(response.body).to include '<input class="form-control" placeholder="Make your next guess" autofocus="autofocus" type="text" name="guess" id="guess"'
    end
  end

  context 'POST /play/:uuid' do
    it 'redirects back to play after a guess was posted' do
      game = GameService::new_game
      post "/play/#{game.uuid}", :params => { :guess => "wrong" }
      expect(response).to redirect_to "/play/#{game.uuid}"
      follow_redirect!
      expect(response).to render_template :play
    end

    it 'redirects back to play with an error message after an guess of invalid size was posted' do
      game = GameService::new_game
      post "/play/#{game.uuid}", :params => { :guess => "wron" }
      expect(response).to redirect_to "/play/#{game.uuid}"
      follow_redirect!
      expect(response).to render_template :play
      expect(response.body).to include 'Error: invalid size'
    end

    it 'redirects back to play with an error message after a guess was posted that is not present in the word list' do
      game = GameService::new_game
      post "/play/#{game.uuid}", :params => { :guess => "wrong" }
      expect(response).to redirect_to "/play/#{game.uuid}"
      follow_redirect!
      expect(response).to render_template :play
      expect(response.body).to include 'Error: word not in word list'
    end
  end

end