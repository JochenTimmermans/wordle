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

    it 'ends the game if word was found' do
      game = GameService::new_game
      game.add_guess game.word.word
      expect(game.ended?).to eq true
      expect(game.won?).to eq true
    end
  end

  context 'guesses left' do
    it 'returns the correct amount of guesses left' do
      game = GameService::new_game
      expect(game.ended?).to eq false
      expect(game.guesses.count).to eq 0
      expect(game.guesses_left).to eq Game::MAX_GUESSES

      i = 1
      until game.guesses_left == 1
        game.add_guess 'bloep'

        expect(game.ended?).to eq false
        expect(game.guesses.count).to eq i
        expect(game.guesses_left).to eq Game::MAX_GUESSES - i

        i += 1
      end

      game.add_guess 'bloep'
      expect(game.guesses_left).to eq 0
      expect(game.ended?).to eq true

      expect {
        game.add_guess 'bloep'
      }.to raise_error RuntimeError
    end
  end
end
