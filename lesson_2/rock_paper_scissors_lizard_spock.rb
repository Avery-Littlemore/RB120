class Rock
  DEFEATS = ['scissors', 'lizard']
  def self.wins?(other_move)
    return true if DEFEATS.include?(other_move.to_s)
    false
  end
end

class Paper
  DEFEATS = ['rock', 'spock']
  def self.wins?(other_move)
    return true if DEFEATS.include?(other_move.to_s)
    false
  end
end

class Scissors
  DEFEATS = ['paper', 'lizard']
  def self.wins?(other_move)
    return true if DEFEATS.include?(other_move.to_s)
    false
  end
end

class Lizard
  DEFEATS = ['paper', 'spock']
  def self.wins?(other_move)
    return true if DEFEATS.include?(other_move.to_s)
    false
  end
end

class Spock
  DEFEATS = ['scissors', 'rock']
  def self.wins?(other_move)
    return true if DEFEATS.include?(other_move.to_s)
    false
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    @value = value
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def >(other_move)
    return Rock.wins?(other_move) if rock?
    return Paper.wins?(other_move) if paper?
    return Scissors.wins?(other_move) if scissors?
    return Lizard.wins?(other_move) if lizard?
    return Spock.wins?(other_move) if spock?

    # rock? && other_move.scissors? ||
    #   rock? && other_move.lizard? ||
    #   paper? && other_move.rock? ||
    #   paper? && other_move.spock? ||
    #   scissors? && other_move.paper? ||
    #   scissors? && other_move.lizard? ||
    #   lizard? && other_move.paper? ||
    #   lizard? && other_move.spock? ||
    #   spock? && other_move.scissors? ||
    #   spock? && other_move.rock?
  end

  def <(other_move)
    rock? && other_move.paper? ||
      rock? && other_move.spock? ||
      paper? && other_move.scissors? ||
      paper? && other_move.lizard? ||
      scissors? && other_move.rock? ||
      scissors? && other_move.spock? ||
      lizard? && other_move.rock? ||
      lizard? && other_move.scissors? ||
      spock? && other_move.paper? ||
      spock? && other_move.lizard?
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    @move = nil
    set_name
  end
end

class RPSGame
  attr_accessor :human, :computer, :score, :move_history, :move_counter

  def initialize
    @human = Human.new
    @computer = Computer.new
    @score = Score.new(human, computer)
    @move_history = {}
    @move_counter = 1
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Goodbye!"
  end

  def display_history
    move_history[move_counter] = "#{human.name}: #{human.move}, #{computer.name}: #{computer.move}"
    if move_counter > 1
      puts "The moves so far have been:"
      move_history.each {|k,v| puts "#{k}. #{v}"}
    end
    self.move_counter += 1
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
      score.add(human)
      score.display
    elsif human.move < computer.move
      puts "#{computer.name} won!"
      score.add(computer)
      score.display
    else
      puts "It's a tie!"
      score.display
    end
  end

  def play_again?
    if score.winner !=false
      puts "We have a winner with 10 points: Congratulations #{score.winner.name}!"
      return false
    end
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end
    return true if answer.downcase == 'y'
    return false if answer.downcase == 'n'
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      display_history
      break unless play_again?
      system 'clear'
    end
    display_goodbye_message
  end
end

class Score
  attr_accessor :human, :computer, :human_score, :computer_score

  def initialize(human, computer)
    @human = human
    @computer = computer
    @human_score = 0
    @computer_score = 0
  end
  
  def add(player)
    if player == human
      self.human_score += 1
    elsif player == computer
      self.computer_score += 1
    end
  end

  def display
    puts "The score is now #{human.name}: #{human_score}, #{computer.name}: #{computer_score}."
  end

  def winner
    if human_score == 10
      human
    elsif computer_score == 10
      computer
    else
      false
    end
  end
end

=begin
Set player and computer's points to 0 each
When the game has finished and we have determined a winner
Add 1 point to winner
Display points
Break when either competitor reaches 10 points
=end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    if name == 'R2D2'
      self.move = Move.new(Move::VALUES.sample) # random
    elsif name == 'Hal'
      self.move = Move.new('scissors') # always scissors
    elsif name == 'Chappie'
      self.move = Move.new('lizard') # always lizard
    elsif name == 'Sonny'
      self.move = Move.new(Move::VALUES[rand(Move::VALUES.size - 2)]) # old school RPS
    else
      self.move = Move.new(['lizard', 'spock', Move::VALUES.sample].sample) # hugely partial to "newer" game variant choices
    end
  end
end

system 'clear'
RPSGame.new.play
