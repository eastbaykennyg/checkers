class Piece
  
  attr_reader :color
  attr_accessor :pos, :kinged, :vector, :neighbors
  
  def initialize(color, pos, board)
    
    @color, @pos, @board, @kinged, = color, pos, board, false
    set_vector
     
  end
  
  def inspect
    @color
  end
  
  def set_vector
    if is_kinged?
      @vector = [
        [-1,  1],
        [-1, -1],
        [1, -1],
        [1,  1]
      ]
    elsif color == "black"
      @vector = [
        [-1,  1],
        [-1, -1]
      ]
    else
      @vector =[
        [1, -1],
        [1,  1]
      ]
    end
  end
  
  def is_kinged?
    self.kinged
  end
  
  def king
    i, j = @pos
    self.kinged = true if i == 0 || i == 7
    
    set_vector
  end
  
  def can_move?
    piece = self
    color = self.color
    neighbors = @board.find_neighbors(pos)
    n_len = neighbors.length
    
    if neighbors[0...(n_len/2)].include?(nil)
      return true
    else
      return false
    end
  end
end
