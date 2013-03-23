class Piece
  
  attr_accessor :color, :pos, :kinged, :vector
  
  def initialize(color, pos, kinged = false)
    
    @color, @pos, @kinged = color, pos, kinged
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
        [1,  1],
        [1, -1]
      ]
    elsif color == "black"
      @vector = [
        [-1,  1],
        [-1, -1]
      ]
    else
      @vector =[
        [1,  1],
        [1, -1]
      ]
    end
  end
  
  def is_kinged?
    self.kinged
  end
  
end
