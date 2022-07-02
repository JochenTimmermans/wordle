class GameService
  def self.new_game
    Game.create(uuid: SecureRandom.uuid, word_id: Word.all.sample.id)
  end

  def self.judge_guess(game, guess)
    '00000'
  end
end