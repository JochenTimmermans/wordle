class GameService
  def self.new_game
    Game.create(uuid: SecureRandom.uuid, word_id: Word.all.sample.id)
  end
end