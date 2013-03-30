require 'debugger'
class Piece
  
  attr_reader :color, :jumps
  attr_accessor :pos, :kinged, :vector, :neighbors
  
  def initialize(color, pos, board)
    
    @color, @pos, @board, @kinged, = color, pos, board, false
    @jumps = []
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
    elsif color == :black
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
  
  def can_jump?
    piece, color = self, self.color
    n_len = @board.find_neighbors(pos).length
    close_neighbors = @board.find_neighbors(pos)[0...(n_len/2)]
    jump_neighbors = @board.find_neighbors(pos)[(n_len/2)..-1]
    n_index, @jumps = [], []
    eligible = false
    
    close_neighbors.each_with_index do |neighbor, i| 
      if neighbor.class == Piece && neighbor.color != color
        eligible = true 
        n_index << i
      end      
    end
    
    if eligible
      jump_neighbors.each_with_index do |neighbor, i|
        if n_index.include?(i) && neighbor == nil
          eligible = true
          x, y, i, j = [self.vector[i], self.pos].flatten
          jump = [ x * 2 + i , y * 2 + j ]
          @jumps << jump 
        end
      end
    end
       
    eligible 
  end
  
  
end
