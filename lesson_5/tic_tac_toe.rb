require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def somebody_won?
    !!winning_marker
  end

  # return winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def potential_threat(attacker_marker, defender_marker)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      markers = squares.map(&:marker)
      if markers.count(attacker_marker) == 2 &&
         markers.count(defender_marker) == 0
        return (line & unmarked_keys).first
      end
    end
    nil
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).map(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_accessor :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  X_MARKER = 'X'
  O_MARKER = 'O'
  FIRST_TO_MOVE = X_MARKER
  attr_reader :board
  attr_accessor :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(X_MARKER)
    @computer = Player.new(O_MARKER)
    @current_marker = FIRST_TO_MOVE
    @human_score = 0
    @computer_score = 0
    @human_name = ''
    @computer_name = ''
  end

  def play
    clear
    display_welcome_message
    set_names
    x_or_o
    who_plays_first
    main_game
    display_goodbye_message
  end

  private

  def validate_x_or_o(answer)
    if answer == 'x'
      human.marker = X_MARKER
      computer.marker = O_MARKER
    elsif answer == 'o'
      human.marker = O_MARKER
      computer.marker = X_MARKER
    else
      false
    end
  end

  def x_or_o
    loop do
      puts "Would you like to play with X or O? (x/o)"
      answer = gets.chomp.downcase
      break if validate_x_or_o(answer)
      puts "Sorry, that's not a valid choice."
    end
  end

  def set_names
    puts "What is your name?"
    @human_name = gets.chomp
    @computer_name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
    puts "Hi #{@human_name}! Today, you will be facing #{@computer_name}."
  end

  def validate_who_plays_first(answer)
    if answer == 'y'
      @current_marker = human.marker
    elsif answer == 'n'
      @current_marker = computer.marker
    else
      false
    end
  end

  def who_plays_first
    loop do
      puts "Would you like to play first? (y/n)"
      answer = gets.chomp.downcase
      break if validate_who_plays_first(answer)
      puts "Sorry, that's not a valid choice."
    end
  end

  def main_game
    loop do
      display_board
      player_move
      display_result
      break unless play_again?
      reset
      display_play_again_message
    end
  end

  def player_move
    loop do
      current_player_moves
      break if board.somebody_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
  end

  def display_goodbye_message
    puts "Thank you for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_board
    puts "You're are #{human.marker}. #{@computer_name} is #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def remaining_squares(squares, delimiter = ',', and_or = 'or')
    case squares.size
    when 1
      squares.first
    when 2
      squares.join(" #{and_or} ")
    else
      squares[-1] = "#{and_or} " + squares.last.to_s
      squares.join("#{delimiter} ")
    end
  end

  def human_moves
    square = nil
    loop do
      puts "Choose a square: #{remaining_squares(board.unmarked_keys)}"
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def computer_moves
    if board.potential_threat(computer.marker, human.marker)
      board[board.potential_threat(computer.marker, human.marker)] = computer.marker
    elsif board.potential_threat(human.marker, computer.marker)
      board[board.potential_threat(human.marker, computer.marker)] = computer.marker
    elsif board.unmarked_keys.include?(5)
      board[5] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker
      puts "You won!"
      @human_score += 1
    when @computer.marker
      puts "Computer won!"
      @computer_score += 1
    else puts "It's a tie!"
    end
  end

  def play_again?
    if @human_score == 5
      puts "You win with a score of #{@human_score} vs #{@computer_score}. Congrats!"
      false
    elsif @computer_score == 5
      puts "Computer wins with a score of #{@human_score} vs #{@computer_score}. Nice try!"
      false
    else
      puts "The score is now #{@human_score} vs #{@computer_score}."
      answer = nil
      loop do
        puts "Would you like to play again? (y or n)"
        answer = gets.chomp.downcase
        break if %w(y n).include?(answer)
        puts "Sorry, that's not a valid choice."
      end
      answer == 'y'
    end
  end

  def clear
    system 'clear'
  end

  def reset
    board.reset
    clear
    who_plays_first
  end

  def display_play_again_message
    puts "Let's play again!"
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def human_turn?
    @current_marker == human.marker
  end
end

game = TTTGame.new
game.play
