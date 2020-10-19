puts 'WELCOME TO HANGMAN!'
puts 'Commands:
                username = Game.new - Start a new game
                username.play - Guess a letter
                username.display_blanks - Show word progress
                username.turn_count - Show number of turns left
                username.reset - Start over with a new word
                username.commands - See list of commands'

class Game
  attr_reader :name, :letter, :secret_word, :secret_word_options, :choice
  attr_accessor :wrong_guess, :dictionary, :blanks

  def initialize
    @turns = 10
    @wrong_guess = []
    choose_word
  end

  def play
    create_blanks if @blanks.nil?
    display_blanks
    input_prompt
    @letter = gets.chomp.downcase
    guess_check
    display_blanks
    turn_count
    check_game_over
  end

  def display_blanks
    print "#{blanks}\n"
  end

  def turn_count
    puts "Turns Left: #{@turns}" if @turns > -1
  end

  def reset
    choose_sample
    @turns = 10
    @wrong_guess = []
    @blanks = nil
    play
  end

  def commands
    puts 'Commands:
                username = Game.new - Start a new game
                username.play - Guess a word
                username.display_blanks - Show word progress
                username.turn_count - Show number of turns left
                username.reset - Start over with a new word
                username.commands - See list of commands'
  end

  private

  def input_prompt
    puts 'Please Enter a Letter:'
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

  def lose
    puts "Game Over! Word was #{secret_word}."
    try_again
  end

  def win
    puts "Congratulations. You guessed #{secret_word}!"
    try_again
  end

  def try_again
    puts '. . .'
    puts 'Play Again? (Y/N):'
    @choice = gets.chomp.downcase
    reset if choice == 'y'
  end

  def check_game_over
    if @turns == -1
      lose
    elsif blanks.join('') == secret_word
      win
    end
  end
end
