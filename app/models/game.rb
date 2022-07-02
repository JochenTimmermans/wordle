class Game < ApplicationRecord
  belongs_to :word
  has_many :guesses

  def add_guess(guess)
    self.guesses.create(attempt: guess, feedback: GameService::judge_guess(self, guess))
  end

  private

end
