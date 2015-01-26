class Board
  attr_accessor :rows

  def start_grid
    generate_bombs

    Array.new(9) do |row|
      Array.new(9) do |col|
        if @bomb_positions.include?([row,col])
          Tile.new(false,true,false,[row,col])
        else
          Tile.new(false,false,false,[row,col])
        end
      end
    end
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

  def empty?(pos)
    self[pos].nil?
  end

  def [](pos)
    x, y = pos[0], pos[1]
    @rows[x][y]
  end


  def []=(pos, mark)
    raise "mark already placed there!" unless empty?(pos)

    x, y = pos[0], pos[1]
    @rows[x][y] = mark
  end


end





class Tile

attr_accessor :revealed, :bomb, :flagged, :position

  def initialize(revealed, bomb, flagged, position)
    @revealed = revealed
    @bomb = bomb
    @flagged = flagged
    @tile_position = position
  end

  def reveal
    @revealed = true
  end

  def neighbors
    x, y = position[0], position[1]


  end

  def neighbors_bomb_count

  end


end
