require 'rails_helper'

RSpec.describe "/", :type => :service do
  let!(:word) {
    Word.create(word: "tests")
  }

  it 'creates a new game' do
    game = GameService.new_game

    expect(game).to be_instance_of Game
    expect(game.word).to eq word
  end

end