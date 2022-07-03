# Seed words

word_list = "lib/data/words.txt"

File.open(word_list, 'r') do |file_handle|
  file_handle.each_line do |word|
    Word.create(word: word.strip)
  end
end

p "Word count: #{Word.all.count}"