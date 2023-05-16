# Create an object-oriented number guessing class for numbers in the range 1 to 100,
#  with a limit of 7 guesses per game. The game should play like this:

class GuessingGame
  # MAX_GUESSES = 7
  # RANGE = 1..100

  attr_reader :num_of_guesses, :range

  def initialize(low_num, high_num)
    @range = (low_num..high_num)
    @number = nil
    @num_of_guesses = nil
  end

  def reset
    @number = rand(range)
    @num_of_guesses = Math.log2(range.last - range.first).to_i + 1
  end

  def display_remaining_guesses
    if num_of_guesses == 1
      puts "You have #{num_of_guesses} guess remaining."
    else
      puts "You have #{num_of_guesses} guesses remaining."
    end
  end

  def retrieve_next_guess
    answer = nil
    loop do
      print "Enter a number between #{range.first} and #{range.last}: "
      answer = gets.chomp.to_i
      if range.cover?(answer)
        break
      else
        print "Invalid guess. "
      end
    end
    @num_of_guesses -= 1
    answer
  end

  def higher_or_lower(guess)
    case
    when guess > @number then puts "Your guess is too high."
    when guess < @number then puts "Your guess is too low."
    end
  end

  def correct?(guess)
    guess == @number
  end

  def evaluate_guess
    guess = retrieve_next_guess
    if correct?(guess)
      puts "That's the number!"
      puts ""
      true
    else
      higher_or_lower(guess)
      false
    end
  end

  def play
    reset
    loop do
      display_remaining_guesses
      if evaluate_guess
        puts "You won!"
        break
      else
        puts ""
      end
      if @num_of_guesses.zero?
        puts "You have no more guesses. You lost!"
        break
      end
    end
  end
end

system 'clear'
game = GuessingGame.new(501, 1500)
game.play

# Note that a game object should start a new game with a new number to guess with each call to #play.

# SIMULATION:
# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That's the number!

# You won!

game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low.

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high.

# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have 1 guess remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have no more guesses. You lost!
