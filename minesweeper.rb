class Board

  def self.blank_grid
    Array.new(9) { Array.new(9) }
  end

  def initialize(rows = self.class.blank_grid)
    @rows = rows
  end

  def [](pos)
    x, y = pos[0], pos[1]
    @rows[x][y]
  end

  # def []=(pos, mark)
  #   raise "mark already placed there!" unless empty?(pos)
  #
  #   x, y = pos[0], pos[1]
  #   @rows[x][y] = mark
  # end




end





class Tile

  def initialize(revealed = false, bomb, flagged = false, position)
    @revealed = revealed?
    @bomb = bomb
    @flagged = flagged
    @tile_position = position
  end



end
