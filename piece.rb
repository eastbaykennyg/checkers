class Piece
  
  attr_reader :color
  attr_accessor :pos, :kinged, :vector, :neighbors
  
  def initialize(color, pos)
    
    @color, @pos, @kinged, = color, pos, false
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
  
end
