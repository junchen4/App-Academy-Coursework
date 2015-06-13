class Game
  attr_accessor :board
  def initialize
    @board = Board.new
    @p1 = HumanPlayer.new(:red)
    @p2 = HumanPlayer.new(:black)
  end


  def play
    players = {:red => @p1, :black => @p2}
    @current_player = :red
    while !@board.game_over?
      begin
        players[@current_player].play_turn(@board)
      rescue InvalidMoveError => e
        puts "This happened...#{e.message}"
      retry
      end
      @current_player = (@current_player == :red) ? :black : :red #Switch players
      @board.render
    end

    puts "#{@current_player} has lost."
  end

end

class HumanPlayer
  attr_accessor :color

  def initialize(color)
    @color = color
  end

  def play_turn(board)
    start_pos = []
    move_sequence = []
    puts "#{color}, What piece would you like to move?"
    print "What is the first coordinate (vertically numbered along the board)?"
    start_pos << gets.chomp.to_i
    print "What is the second coordinate (horizontally numbered along the board)?"
    start_pos << gets.chomp.to_i

    puts "What is your move? If a sequence, please enter move one at a time and hit enter. Press 'q' to quit."
    puts "Moves: up_left, up_right, down_left, down_right. Directions are relative to player's side"
    while true
      input_str = gets.chomp
      break if input_str == 'q'
      move_sequence << input_str.to_sym
    end

    board.move_piece(@color, start_pos, move_sequence)
  end

end
