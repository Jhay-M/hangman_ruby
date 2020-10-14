class Game
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
    turn_count
    check_game_over
  end

  def choose_word
    @dictionary = File.readlines '5desk.txt'
    @dictionary.map!(&:chomp)
    choose_sample
  end

  def choose_sample
    @secret_word_options = @dictionary.reject { |word| word.size < 5 || word.size > 12 }
    @secret_word = @secret_word_options.sample.downcase
  end

  def create_blanks
    @blanks = @secret_word.split('').map do |char|
      char = '_'
    end
  end

  def guess_check
    if !@secret_word.include?(@letter)
      @turns -= 1
      tries = (@wrong_guess << @letter).join(', ')
      puts "Wrong Guesses: (#{tries})"
    else
      @secret_word.split('').each_with_index do |value, idx|
        @blanks[idx] = @letter if value == @letter
      end
    end
    print @blanks
  end

  def turn_count
    puts "Turns Left: #{@turns}"
  end

  def check_game_over
    if @turns == -1
      puts "Game Over! Word was #{@secret_word}."
      reset
    elsif @blanks.join('') == @secret_word
      puts "Congratulations #{@name}. You guessed #{@secret_word}!"
      reset
    end
  end

  def reset
    choose_sample
    @turns = 10
    @wrong_guess = []
    @blanks = nil
  end
end
