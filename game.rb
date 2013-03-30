require './board.rb'
require 'debugger'

ALPHAS = {
  "a" => 0,
  "b" => 1,
  "c" => 2,
  "d" => 3,
  "e" => 4,
  "f" => 5,
  "g" => 6,
  "h" => 7,
  
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
  
  def play
    
    
  end
  
end



class HumanPlayer
  
  attr_reader :color, :board
  attr_accessor :pieces, :force_moves
  
  def initialize(color, board)
    @color, @board = color, board
    update_pieces
  end

  def pick_piece
    start_pos = nil
    neighbors = []
    piece_color = nil
    @board.display
    puts "#{@color.capitalize} player's turn,"

    until start_pos != nil
      puts "Please select a piece to move (Example: 2A)"
      temp = gets.chomp.downcase.split("")
      unless (0..7).include?(temp[0].to_i) && ALPHAS.include?(temp[1])
        @board.display
        puts "That's not even a proper coordinate" 
        start_pos = nil
        next
      end
      start_pos = [temp[0].to_i, ALPHAS[temp[1]]]
      unless @board.piece_at(start_pos) != nil # ===========> if selection is empty
        @board.display
        puts "There's no piece there"
        start_pos = nil
        next
      else
        piece_color = @board.piece_at(start_pos).color
        if piece_color != @color # =========================> if selection is wrong color
          @board.display
          puts "That's not your piece" 
          start_pos = nil
          next
        end
      end
      nbrs = @board.find_neighbors(start_pos) # ============> finds surrounding pieces
 
      if @board.piece_at(start_pos).can_move?
        start_pos
      else
        @board.display
        puts "You can't move that piece"
        start_pos = nil
      end 
    end
    
    start_pos
  end
  
  def update_pieces
    @pieces = []
    @board.rows.each do |row|
      row.each do |spot|
        unless spot.nil?
          @pieces << spot unless spot.color != color
        end
      end
    end
  end
  
  def force_moves?
    ans = false
    @force_moves = []
    self.pieces.each do |piece|
      if piece.can_jump?
        @force_moves << piece.pos
        ans = true
      end
    end
    
    ans
  end

end #<===== HumanPlayerClass end