class Game < ApplicationRecord
  belongs_to :word
  has_many :guesses

  MAX_GUESSES = 6

  def add_guess(guess)
    if self.ended?
      fail("Game has ended")
    end

    self.guesses.create(attempt: guess, feedback: GameService::judge_guess(self, guess))
  end

  def guesses_left
    MAX_GUESSES - self.guesses.count
  end

  def ended?
    self.guesses_left < 1 || self.won?
  end

  def won?
    !self.guesses.find_by_attempt(self.word.word).nil?
  end
end
