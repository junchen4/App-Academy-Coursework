class Board
  attr_accessor :squares, :pieces

  def initialize
    @squares = Array.new(8) { Array.new(8) }
    place_starting_pieces
  end

  def [](coordinates) #NEED TO USE DOUBLE BRACKETS TO PASS "X, Y"
    @squares[coordinates[1]][coordinates[0]]
  end

  def []=(coordinates, new_value) #NEED TO USE DOUBLE BRACKETS TO PASS "X, Y"
    @squares[coordinates[1]][coordinates[0]] = new_value
  end

  def in_check?(color)
    #If any of the opposite color pieces can move to king_position, then in check
    if color == :white
      king_position = pieces.select{|piece| piece.color == :white && piece.class == King}.first.position
      pieces.values.any? {|piece| pieces.color == :black && piece.moves.include?(king_position) }
    else
      king_position = pieces.select{|piece| piece.color == :black && piece.class == King}.first.position
      pieces.values.any? {|piece| pieces.color == :white && piece.moves.include?(king_position) }
    end

  end

  def move(start, end_pos)
    piece_at_start = self[start]
    if piece_at_start.nil?
      raise ArgumentError.new("No piece there....")
    elsif piece_at_start.moves.include?(end_pos)
      if self[end_pos]
        captured_piece = pieces.select {|piece| piece.position == end_pos}.first
        pieces.delete(captured_piece)
      end
      piece_at_start.position = end_pos #Update position of the piece (object)
      self[start] = nil
      self[end_pos] = piece_at_start #Update position on the board to include the moved piece (object)
    else
      raise ArgumentError.new("You can't move there dude")
    end
  end

  def move!(start, end_pos)
    piece_at_start = self[start]
    if piece_at_start.nil?
      raise ArgumentError.new("No piece there....")
    else
      if self[end_pos]
        captured_piece = pieces.select {|piece| piece.position == end_pos}.first
        pieces.delete(captured_piece)
      end
      piece_at_start.position = end_pos
      self[start] = nil
      self[end_pos] = piece_at_start
    end
  end

  def dup #GET PIECE HASHES TO NEW BOARD COPY
    board_copy = Board.new()
    board_copy.squares = @squares.dup
    board_copy.pieces = []

    board_copy.squares.each_with_index do |row, i|
      board_copy.squares[i] = row.dup
      row.each_with_index do |piece, j|
        unless piece.nil?
          row[j] = piece.dup(squares_copy)
          board_copy.pieces << row[j]
        end
      end
    end
  end


  def place_starting_pieces
    pieces = []

    @white_pieces = {
      king: King.new(:white, [4,7], self),
      queen: Queen.new(:white, [3,7], self),
      rook1: Rook.new(:white, [0,7], self),
      rook2: Rook.new(:white, [7,7], self),
      knight1: Knight.new(:white, [1,7], self),
      knight2: Knight.new(:white, [6,7], self),
      bishop1: Bishop.new(:white, [2,7], self),
      bishop2: Bishop.new(:white, [5,7], self)
    }

    0.upto(7) do |x|
      @white_pieces["pawn#{x+1}".to_sym] = Pawn.new(:white, [x,6], self)
    end

    @black_pieces = {
      queen: Queen.new(:black, [3,0], self),
      king: King.new(:black, [4,0], self),
      rook1: Rook.new(:black, [0,0], self),
      rook2: Rook.new(:black, [7,0], self),
      knight1: Knight.new(:black, [1,0], self),
      knight2: Knight.new(:black, [6,0], self),
      bishop1: Bishop.new(:black, [2,0], self),
      bishop2: Bishop.new(:black, [5,0], self)
    }

    0.upto(7) do |x|
      @black_pieces["pawn#{x+1}".to_sym] = Pawn.new(:black, [x,1], self)
    end

    @white_pieces.values.each do |piece|
      self[piece.position] = piece
      pieces << piece
    end

    @black_pieces.values.each do |piece|
      self[piece.position] = piece
      pieces << piece
    end

    @white
  end
end
