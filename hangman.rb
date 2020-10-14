class Game
  attr_reader :name, :letter, :secret_word, :secret_word_options
  attr_accessor :wrong_guess, :dictionary, :blanks

  def initialize(name)
    @name = name
    @turns = 10
    @wrong_guess = []
    choose_word
  end

  def play
    @letter = gets.chomp.downcase
    create_blanks if @blanks.nil?
    guess_check
    display_blanks
    turn_count
    check_game_over
  end

  def open_dictionary
    @dictionary = File.readlines '5desk.txt'
  end

  def clean_dictionary
    dictionary.map!(&:chomp)
  end

  def choose_options
    @secret_word_options = dictionary.reject { |word| word.size < 5 || word.size > 12 }
  end

  def choose_sample
    @secret_word = secret_word_options.sample.downcase
  end

  def choose_word
    open_dictionary
    clean_dictionary
    choose_options
    choose_sample
  end

  def create_blanks
    @blanks = secret_word.split('').map do |char|
      char = '_'
    end
  end

  def correct_guess
    secret_word.split('').each_with_index do |value, idx|
      blanks[idx] = letter if value == letter
    end
  end

  def incorrect_guess
    @turns -= 1
    tries = (wrong_guess << letter).join(', ')
    puts "Wrong Guesses: (#{tries})"
  end

  def guess_check
    secret_word.include?(letter) ? correct_guess : incorrect_guess
  end

  def display_blanks
    print blanks
  end

  def turn_count
    puts "Turns Left: #{@turns}"
  end

  def win
    puts "Game Over! Word was #{secret_word}."
    reset
  end

  def lose
    puts "Congratulations #{name}. You guessed #{secret_word}!"
    reset
  end

  def check_game_over
    win if @turns == -1
    lose if blanks.join('') == secret_word
  end

  def reset
    choose_sample
    @turns = 10
    @wrong_guess = []
    @blanks = nil
  end
end
