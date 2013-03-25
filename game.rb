require_relative 'board.rb'
require 'debugger'

ALPHAS = {
  "a" => 0,
  "b" => 1,
  "c" => 2,
  "d" => 3,
  "e" => 4,
  "f" => 5,
  "g" => 6,
  "h" => 7
  
}

class Game
  attr_reader :board, :players

  def initialize
    @board = Board.new
    @players = {
      red: HumanPlayer.new(:red, @board),
      black: HumanPlayer.new(:black, @board)
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

  def pick_piece
    start_pos = nil
    neighbors = []
    piece_color = nil
    puts "#{@color.capitalize} player's turn,"

    until start_pos != nil
      puts "Please select a piece to move (Example: 2A)"
      temp = gets.chomp.downcase.split("")
      start_pos = [temp[0].to_i, ALPHAS[temp[1]]]
      unless @board.piece_at(start_pos) != nil # ===========> if selection is empty
        puts "There's no piece there"
        start_pos = nil
        next
      else
        piece_color = @board.piece_at(start_pos).color
        if piece_color != @color # =========================> if selection is wrong color
          puts "That's not your piece" 
          start_pos = nil
          next
        end
      end
      nbrs = @board.find_neighbors(start_pos) # ============> finds surrounding pieces
 
      # ====================================================> checks to see if immediate neighbors are player's color
      if nbrs[0...(nbrs.length/2)].include?(nil) || !nbrs[0...(nbrs.length/2)].each{ |x| x.color == piece_color }
        start_pos
      else
        puts "You can't move that piece"
        start_pos = nil
      end 
      
    end
    
    start_pos
  end

end #<===== HumanPlayerClass end