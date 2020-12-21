class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  
  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = []
    @secret_word.length.times {@guess_word << "_"}
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end
  
  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end
  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(ch)
    @attempted_chars.include?(ch)
  end

  def get_matching_indices(ch)
    indices = []
    @secret_word.each_char.with_index {|ele, i| indices << i if ele  == ch}
    indices
  end

  def fill_indices(ch, arr)
    arr.each {|i| @guess_word[i] = ch}
  end

  def try_guess(ch)
    if already_attempted?(ch)
      print "that has already been attempted"
      return false
    else
      @attempted_chars << ch
      if get_matching_indices(ch).empty?
        @remaining_incorrect_guesses -= 1
      else
        fill_indices(ch, get_matching_indices(ch))
      end
      return true
    end
  end

  def ask_user_for_guess
    print "Enter a char:"
    ch = gets.chomp
    try_guess(ch)
  end

  def win?
    if @guess_word.join("") == @secret_word
      puts "WIN"
      return true
    else
      false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      return true
    else
      false
    end
  end

  def game_over?
    if lose? || win?
      puts @secret_word
      return true
    else
      return false
    end
  end
end

