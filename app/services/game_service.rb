class GameService
  def self.new_game
    Game.create(uuid: SecureRandom.uuid, word_id: Word.all.sample.id)
  end

  def self.judge_guess(game, guess)
    word = game.word.word
    word_letters = word.split('')
    guess_letters = guess.split('')

    result_string = ''

    guess_letters.each_with_index do |char, index|
      if char == word_letters[index]
        result_string += '1'
        next
      end

      if word_letters.include?(char)
        result_string += '2'
        next
      end

      result_string += '0'
    end

    result_string
  end
end