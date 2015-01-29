#require 'colorize'
require 'colorize'
require_relative 'piece'

class Board
  attr_accessor :rows

  def initialize(fill_board = true)
    make_starting_grid(fill_board)
  end

  def [](pos)
    i, j = pos
    @rows[i][j]
  end

  def []=(pos, piece)
    i, j = pos
    @rows[i][j] = piece
  end

  def add_piece(piece, pos)
    self[pos] = piece
  end

  def delete(position)
    piece_to_delete = self.pieces.select {|piece| piece.position == position}.first
    piece_to_delete.position = nil
    self[position] = nil
  end

  #Use dup to test for valid moves
  def valid_move_seq?(start_position, move_sequence)
    board_copy = self.dup
    start_piece = board_copy.pieces.select {|piece| piece.position == start_position}.first

    begin
      start_piece.perform_moves!(move_sequence)
    rescue InvalidMoveError => e
      puts "Whoops, got an issue there: #{e.message}"
      return false
    else
      true
    end
  end

  def move_piece(color, start_position, move_sequence)
    start_piece = pieces.select {|piece| piece.position == start_position}.first
    raise InvalidMoveError.new("No piece there, sir!") if start_piece.nil?
    raise InvalidMoveError.new("Not a valid move!") if valid_move_seq?(start_position, move_sequence) == false
    raise InvalidMoveError.new("Sneaky, sneaky...pick your own color please!") if color != start_piece.color

    prev_position = start_position
    start_piece.perform_moves(move_sequence)
    self[prev_position] = nil #Set position from where piece moved to nil
    add_piece(start_piece, start_piece.position)
    #self[start_piece.position] = start_piece #Add the now updated start_piece to the board at the right location
  end

  def game_over?
    pieces.select{|piece| piece.color == :red}.empty? || pieces.select{|piece| piece.color == :black}.empty?
  end

  def dup
    new_board = Board.new(false)

    pieces.each do |piece| #Calls "pieces" method, which returns an array of all the pieces (NOT nil's)
      piece.class.new(piece.color, piece.position.dup, new_board, piece.is_king)
    end

    new_board
  end

  def pieces
    @rows.flatten.compact
  end

  def render
    puts
    display_board = Array.new(8) { Array.new(8) }
    is_colored = false
    row_counter = 8
    puts "    0     1    2    3    4    5    6    7 "
    display_board.each_with_index do |row, y|
      print " #{7 - (row_counter - 1)} "
      row.each_with_index do |square, x|
        if self[[y,x]].nil?
          row[y] = "     "
        else
          row[y] = "#{self[[y,x]].color}" if self[[y,x]].color == :black
          row[y] = " #{self[[y,x]].color} " if self[[y,x]].color == :red
        end
        if is_colored
          row[y] = row[y].colorize(:background => :light_green)
          is_colored = false
        else
          row[y] = row[y].colorize(:background => :light_white)
          is_colored = true
        end
        print "#{row[y]}"
      end
      puts
      puts
      is_colored = !is_colored
      row_counter -= 1
    end
  end


  def fill_pieces(color)
    @pieces = []
    even = [0,2,4,6]
    odd = [1,3,5,7]

    odd.each do |odd_idx|
      Piece.new(:red, [odd_idx, 0], self)
      Piece.new(:red, [odd_idx, 2], self)
      Piece.new(:black, [odd_idx, 6], self)
    end

    even.each do |even_idx|
      Piece.new(:red, [even_idx, 1], self)
      Piece.new(:black, [even_idx, 5], self)
      Piece.new(:black, [even_idx, 7], self)
    end

  end

  def make_starting_grid(fill_board)
    @rows = Array.new(8) { Array.new(8) }
    return unless fill_board
    [:red, :black].each { |color| fill_pieces(color) }
  end

end
