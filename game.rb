require_relative 'board.rb'


class Game
  attr_reader :board

  def initialize
    @board = Board.new
    @players = {
      :white => HumanPlayer.new(:red),
      :black => HumanPlayer.new(:black)
    }
    @current_player = :white
  end
  
end


class Player
  
  attr_reader :color
  attr_accessor :board
  
  
  
  
end

class HumanPlayer < Player
  


end