class Board
  attr_accessor :rows

  def self.blank_grid
    Array.new(9) { Array.new(9) }

  end

  def start_grid
    generate_bombs
    @rows = self.class.blank_grid

    @rows.each_with_index do |row, index1|

      row.each_with_index do |space, index2|

        if @bomb_positions.include?([index1, index2])
          self.[]=([index1,index2],Tile.new(false, true, false, [index1, index2]))
        else
          self.[]=([index1,index2],Tile.new(false, false, false, [index1, index2]))
        end
      end
    end

    @rows

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


  def place_bombs
    #generate_bombs
    @bomb_positions.each do |position|
      self.[]=(position, "B")
    end
  end

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

  def initialize(revealed, bomb, flagged, position)
    @revealed = revealed
    @bomb = bomb
    @flagged = flagged
    @tile_position = position
  end

  def reveal(pos)

  end


end
