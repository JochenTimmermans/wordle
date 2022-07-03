require 'rails_helper'

RSpec.describe "/", :type => :service do
  let!(:word) {
    Word.create(word: "tests")
  }

  context 'validate_guess' do

    it 'validates a valid guess' do
      validation = GuessService::validate_guess 'tests'
      expect(validation[:status]).to eq 'success'
    end

    it 'detects an invalid word size' do
      validation = GuessService::validate_guess 'test'
      expect(validation[:status]).to eq 'error'
      expect(validation[:message]).to eq 'invalid size'
    end

    it 'detects words valid in size but not present in the word list' do
      validation = GuessService::validate_guess 'pests'
      expect(validation[:status]).to eq 'error'
      expect(validation[:message]).to eq 'word not in word list'
    end

  end

end