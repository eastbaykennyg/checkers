#!/bin/env ruby
# encoding: UTF-8
require 'debugger'
require 'colorize'
require_relative 'piece.rb'

class Board
    
  attr_accessor :pieces, :rows

  def initialize  
    @pieces = []
    
    make_board 
    set_pieces
    display
 
  end
  
  def inspect
    nil
  end

  def make_board
    @rows = Array.new(8) { Array.new(8) }
  end
  
  def set_pieces
    @rows.each_with_index do |row, i|
      row.each_with_index do |spot, j|
        if i < 3 && (i+j) % 2 != 0
          @rows[i][j] = Piece.new(:red, [i,j])
          @pieces << @rows[i][j]
        end
        if i > 4 && (i+j) % 2 != 0
          @rows[i][j] = Piece.new(:black, [i,j])
          @pieces << @rows[i][j]
        end
      end
    end
  end
  
  def piece_at(pos)
    i, j = pos
    @rows[i][j]
  end
  
  def display
    system("clear")
    puts"   A  B  C  D  E  F  G  H "
    @rows.each_with_index do |row, i|
      row_string = i.to_s + " "
      row.each_with_index do |spot, j|
        if (i+j) % 2 == 0
          row_string << "   ".colorize(:background => :white)
        else
          if spot == nil
            row_string << "   ".colorize(:background => :cyan)
          elsif spot.color == :black
            row_string << " ⬤ ".colorize(:color => :black, :background => :cyan) unless spot.is_kinged?
            row_string << " Ⓚ ".colorize(:color => :black, :background => :cyan) if spot.is_kinged?
          else
            row_string << " ⬤ ".colorize(:color => :red, :background => :cyan) unless spot.is_kinged?
            row_string << " Ⓚ ".colorize(:color => :red, :background => :cyan) if spot.is_kinged?
          end
        end
      end
      puts row_string
    end
    
    nil
  end
  
  def move_piece(start_pos, end_pos)
    x, y = start_pos
    i, j = end_pos
    temp_vector = [ i - x, j - y ].map! { |x| x / (x.abs) }
    
    
    if @rows[x][y] == nil # =================================> if start position is empty
      "You have to select a piece."
    elsif @rows[i][j] != nil # ==============================> if end position is NOT empty 
      "You can't move there."
    elsif @rows[x][y].vector.include?(temp_vector) # ========> confirms vector before making move
      @rows[i][j], @rows[x][y] = @rows[x][y], @rows[i][j]
    else
      "You can't move like that."
    end
    
    display ### !!! this needs to be moved
  end ### !!! display needs to be moved
  
  def remove_piece(pos)
    i, j = pos
    @rows[i][j] = nil
    @pieces.delete(@rows[i][j])
  end
  
  def find_neighbors(pos)
    x, y = pos
    piece = @rows[x][y]
    piece.neighbors = []

    piece.vector.each do |i, j| 
      (i+x) < 8 && (j+y) < 8 ? piece.neighbors << @rows[i + x][j + y] : piece.neighbors << "oob"
      p @rows[i + x][j + y]
    end
    piece.vector.each do |i, j| 
      i *= 2
      j *= 2
      (i+x) < 8 && (j+y) < 8 ? piece.neighbors << @rows[i + x][j + y] : piece.neighbors << "oob"
    end
    
  end
  
end