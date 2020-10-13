require 'pry'

class Game
  def initialize(name)
    @name = name
    @turns = 10
    @wrong_guess = []
    choose_word
  end

  def play
    @letter = gets.chomp
    turn_count
    display_blanks
    guess_check
  end

  def choose_sample
    @secret_word_options = @dictionary.reject { |word| word.size < 5 || word.size > 12 }
    @secret_word = @secret_word_options.sample.downcase
  end

  def turn_count
    @turns -= 1
    puts "Turns Left: #{@turns}"
  end

  def display_blanks
    if @blanks.nil?
      @blanks = @secret_word.split('').map do |char|
        char = '_'
      end
    end
    p @blanks
  end

  def guess_check
    @letter.downcase!
    @secret_word.split('').each_with_index do |value, idx|
      @blanks[idx] = @letter if value == @letter
    end
  end

  def choose_word
    @dictionary = File.readlines '5desk.txt'
    @dictionary.map!(&:chomp)
    choose_sample
  end
end
