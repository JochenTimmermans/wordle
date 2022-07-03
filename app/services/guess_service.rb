class GuessService
  def self.validate_guess(word)
    if word.size != 5
      return {
        status: 'error',
        message: 'invalid size'
      }
    end

    if Word.where(word: word).empty?
      return {
        status: 'error',
        message: 'word not in word list'
      }
    end

    {
      status: 'success'
    }
  end
end