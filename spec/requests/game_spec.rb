require 'rails_helper'

RSpec.describe "Game requests", :type => :request do

  context '/' do
    it 'shows the Wordle title' do
      get '/'

      expect(response).to render_template(:index)
      expect(response.body).to include('<h1>Wordle</h1>')
      expect(response.body).to include('Play Wordle')
    end
  end

  context '/play' do
    let!(:word) {
      Word.create(word: "tests")
    }

    it 'redirects to a fresh game if not provided with a uuid' do
      get '/play'

      game = Game.all.first
      expect(response).to redirect_to "/play/#{game.uuid}"
    end
  end

end