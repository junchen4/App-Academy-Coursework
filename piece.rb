class InvalidMoveError < StandardError
end

class Piece
  attr_accessor :color, :position, :board, :is_king
  #attr_reader :move_directions

  def initialize(color, position, board, is_king = false)
    @color, @position, @board, @is_king = color, position, board, is_king
   #First coordinate in position is the columns increasing rightwards
   #Second coordinate is rows increasing upwards (x,y)

    board.add_piece( self, [position[0],position[1]] ) #Pass coordinates "flipped" because arrays are indexed differently from how
                                                       #this class defined the board coordinates
  end

  def perform_slide(direction) #Moving up/down left/right relative to the vantage point of own side
    @position = [ @position[0] + move_diffs[direction][0], @position[1] + move_diffs[direction][1] ]

    #After moving, then check to see if the piece should be promoted to king
    @is_king = true if maybe_promote == true
  end

  def perform_jump(direction)
    @position = [ @position[0] + move_diffs[direction][0] * 2, @position[1] + move_diffs[direction][1] * 2 ]

    #After moving, check to see if the piece should be promoted to king
    is_king = true if maybe_promote == true
  end

  def perform_moves(move_sequence)
    perform_moves!(move_sequence) if @board.valid_move_seq?(self.position, move_sequence)
  end

  def perform_moves!(move_sequence) #move_sequence is an array of moves
    if move_sequence.count == 1
      only_move = move_sequence.first
      prev_position = self.position
      raise InvalidMoveError.new("Not one of your moves!") if !self.move_diffs.keys.include?(only_move)
      perform_slide(only_move)
      raise InvalidMoveError.new("Off the board yo...") if self.position.any? {|idx| !idx.between?(0,7)} #Off the grid
      if self.board.pieces.any? {|piece| piece != self && piece.position == self.position && piece.color == self.color}
        raise InvalidMoveError.new("You are blocked!")
      elsif self.board.pieces.any? {|piece| piece != self && piece.position == self.position && piece.color != self.color} #opposite color is in the way
        perform_slide(only_move)
        current_position = self.position #New position after performing the jump
        middle_position = [ (prev_position[0] + current_position[0]) / 2, (prev_position[1] + current_position[1]) / 2]
        self.board.pieces.delete_if {|piece| piece.position == middle_position} #Delete piece from pieces array
        self.board[middle_position] = nil
        raise InvalidMoveError.new("Off the board yo...") if self.position.any? {|idx| !idx.between?(0,7)} #Off the grid
        raise InvalidMoveError.new("You are blocked!") if self.board.pieces.any? {|piece| piece != self && piece.position == self.position}
      end
    else #move sequence is longer than 1 move, so must all be jumps
      move_sequence.each do |move|
        prev_is_king = @is_king
        @is_king = true #During combination jumps, the piece can move in any direction. Will reset to false at end of moves unless
                        #has moved to opposite end of board (becomes king at this point)
        raise InvalidMoveError.new("Not one of your moves!") if !self.move_diffs.keys.include?(move)
        prev_position = self.position
        perform_jump(move)
        current_position = self.position #New position after performing the jump
        middle_position = [ (prev_position[0] + current_position[0]) / 2, (prev_position[1] + current_position[1]) / 2]
        raise InvalidMoveError.new("No piece to jump!") if !self.board.pieces.any? {|piece| piece.color != self.color && piece.position == middle_position} #if there are no opposite-colored pieces that are in the middle position
        raise InvalidMoveError.new("Another piece there!") if self.board.pieces.any? {|piece| piece != self && piece.position == self.position}
        raise InvalidMoveError.new("Off the board yo...") if self.position.any? {|idx| !idx.between?(0,7)} #Off the grid

        #if we pass the above errors, then move was valid, so we can set the board's middle position to nil since the piece there was jumped
        self.board.pieces.delete_if {|piece| piece.position == middle_position} #Delete piece from pieces array
        self.board[middle_position] = nil
        #Set to whatever is_king was previously before the combo jumps unless piece ended up at opposite side of board (king)
        @is_king = prev_is_king unless self.position[1] == (@color == :red)? 7 : 0
      end
    end
  end

  def move_diffs #directions that a checkers piece can move towards
    move_diffs_hash = Hash.new{|h,k| h[k] = []}
    if @color == :red
      move_diffs_hash[:up_left] = [-1,+1] #Move up left, vantage point red
      move_diffs_hash[:up_right] = [+1,+1] #Move up right
      if is_king == true
        move_diffs_hash[:down_left] = [-1,-1]
        move_diffs_hash[:down_right] = [+1,-1]
      end
    else #piece color is black
      move_diffs_hash[:up_left] = [+1,-1] #Up left, vantage point black
      move_diffs_hash[:up_right] = [-1,-1] #Up right
      if is_king == true
        move_diffs_hash[:down_left] = [+1,+1]
        move_diffs_hash[:down_right] = [-1,+1]
      end
    end

    move_diffs_hash
  end

  def maybe_promote
    if @color == :red
      return true if @position[1] == 7
    else
      return true if @position[1] == 0
    end
  end

end
