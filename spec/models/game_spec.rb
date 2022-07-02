require 'rails_helper'

RSpec.describe Game, type: :model do

  let!(:word) {
    Word.create(word: "tests")
  }

  context 'add_guess' do
    it 'adds a guess' do
      game = GameService::new_game
      expect(game.guesses.count).to eq 0
      game.add_guess 'wrong'

      expect(game.guesses.count).to eq 1
      expect(game.guesses.first.attempt).to eq 'wrong'
    end
  end
end
