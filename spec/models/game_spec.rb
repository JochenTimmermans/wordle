require 'rails_helper'

RSpec.describe Game, type: :model do

  let!(:word) {
    Word.create(word: "tests")
  }

  context 'add_guess' do
    it 'adds and judges a guess correctly as wrong' do
      attempt = 'wrong'

      game = GameService::new_game
      expect(game.guesses.count).to eq 0
      game.add_guess attempt

      expect(game.guesses.count).to eq 1
      guess = game.guesses.first
      expect(guess.attempt).to eq attempt
      expect(guess.feedback).to eq '00000'
    end

    it 'adds and judges a guess correctly as correct' do
      attempt = 'tents'

      game = GameService::new_game
      expect(game.guesses.count).to eq 0
      game.add_guess attempt

      expect(game.guesses.count).to eq 1

      guess = game.guesses.first
      expect(guess.attempt).to eq attempt
      expect(guess.feedback).to eq '11011'
    end

    it 'adds and judges a guess correctly as out-of-place' do
      game = GameService::new_game
      expect(game.guesses.count).to eq 0
      game.add_guess 'sssst'

      expect(game.guesses.count).to eq 1
      guess = game.guesses.first
      expect(guess.attempt).to eq 'sssst'
      expect(guess.feedback).to eq '22122'
    end
  end
end
