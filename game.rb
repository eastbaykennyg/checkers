require_relative 'board.rb'
require 'debugger'

class Game
  attr_reader :board, :players

  def initialize
    @board = Board.new
    @players = {
      :red => HumanPlayer.new(:red, @board),
      :black => HumanPlayer.new(:black, @board)
    }
    @current_player = :black
  end
  
  def inspect
    nil
  end
  
end



class HumanPlayer
  
  attr_reader :color, :board
  attr_accessor :pieces
  
  def initialize(color, board)
    @color, @board = color, board
    @pieces = @board.pieces.select {|piece| piece.color == @color}
  end

  def play
    start_pos = nil
    
    until start_pos
      puts "#{@color.capitalize} player's turn, please select a piece to move (2A)"
      start_pos = gets.chomp.split("").map!{|x| x.to_i}
      unless @board.piece_at(start_pos)
        puts "There's no piece there"
        start_pos = nil
        else
          if @board.piece_at(start_pos).color != @color
            puts "That's not your piece" 
            start_pos = nil
          end
        end
    end
    
  end

end