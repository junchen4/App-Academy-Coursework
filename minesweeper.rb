class Board
  attr_accessor :rows

  def start_grid
    generate_bombs

    Array.new(9) do |row|
      Array.new(9) do |col|
        if @bomb_positions.include?([row,col])
          Tile.new(false,true,false,[row,col],self)
        else
          Tile.new(false,false,false,[row,col],self)
        end
      end
    end
  end


  def lose?
    @rows.each_with_index do |row,row_idx|
      row.each_with_index do |col, col_idx|
          if self.[]([row_idx,col_idx]).bomb && self.[]([row_idx,col_idx]).revealed
            return true
          end
      end
    end
    false
  end

  def win?
    #all bombs flagged, everything else revealed
    @rows.each_with_index do |row,row_idx|
      row.each_with_index do |col,col_idx|
        if !(self.[]([row_idx,col_idx]).bomb && self.[]([row_idx,col_idx]).flagged) || !(self.[]([row_idx,col_idx]).revealed && !self.[]([row_idx,col_idx]).bomb)
          return false
        end
      end
    end
    true
  end




  def generate_bombs
    @bomb_positions = []

    while @bomb_positions.count < 10
      p1 = (0..8).to_a.sample
      p2 = (0..8).to_a.sample

      if !@bomb_positions.include?([p1,p2])
        @bomb_positions << [p1,p2]
      end
    end
    @bomb_positions
  end

  def initialize(rows = self.start_grid) ###might need to change to play grid
    @rows = rows
  end



  # def place_bombs
  #   #generate_bombs
  #   @bomb_positions.each do |position|
  #     self.[]=(position, "B")
  #   end
  # end

  # def empty?(pos)
  #   self[pos].nil?
  # end

  def [](pos)
    x, y = pos[0], pos[1]
    @rows[x][y]
  end

  #
  # def []=(pos, mark)
  #   raise "mark already placed there!" unless empty?(pos)
  #
  #   x, y = pos[0], pos[1]
  #   @rows[x][y] = mark
  # end


end





class Tile

attr_accessor :revealed, :bomb, :flagged
attr_reader :board, :position

  def initialize(revealed, bomb, flagged, position, board)
    @board = board
    @revealed = revealed
    @bomb = bomb
    @flagged = flagged
    @position = position
  end

  def reveal
    @revealed = true
    if self.neighbors_bomb_count == 0
      self.neighbors.each do |neighbor|
        neighbor.reveal unless neighbor.revealed
      end
    end
    @revealed
  end

  def flag
    @flagged = true
  end

  def neighbor_coordinates
    x, y = self.position[0], self.position[1]
    neighbor_coordinates = []
    row = [x-1, x, x+1]
    col = [y-1, y, y+1]

    row.each do |el1|
      col.each do |el2|
        if el1.between?(0,8) && el2.between?(0,8) && !(el1 == x && el2 == y)
          neighbor_coordinates << [el1,el2]
        end
      end
    end
    neighbor_coordinates
  end

  def neighbors
    neighbors = []
    self.neighbor_coordinates.each do |position|
      neighbors << @board.[](position)
    end
    neighbors

  end

  def neighbors_bomb_count
    bomb_counter = 0
    neighbors.each do |neighbor|
      if neighbor.bomb
        bomb_counter += 1
      end
    end
    bomb_counter
  end


end
