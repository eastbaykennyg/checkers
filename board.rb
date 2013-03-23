#!/bin/env ruby
# encoding: UTF-8

require 'colorize'
require_relative 'piece.rb'

class Board
    
  attr_accessor :pieces, :rows

  def initialize  
    @pieces = []
    
    make_board 
    set_pieces
    display_board
 
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
          @rows[i][j] = Piece.new("red", [i,j])
        end
        if i > 4 && (i+j) % 2 != 0
          @rows[i][j] = Piece.new("black", [i,j])
        end
      end
    end
  end
  
  def display_board
    system("clear")
    puts"   0  1  2  3  4  5  6  7 "
    @rows.each_with_index do |row, i|
      row_string = i.to_s + " "
      row.each_with_index do |spot, j|
        if (i+j) % 2 == 0
          row_string << "   ".colorize(:background => :red)
        else
          if spot == nil
            row_string << "   ".colorize(:background => :white)
          elsif spot.color == "black"
            row_string << " ◍ ".colorize(:color => :black, :background => :white)
          else
            row_string << " ◍ ".colorize(:color => :red, :background => :white)
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
    temp_vector = [ i - x, j - y ]
    
    
    if @rows[x][y] == nil # ==============> if start position is empty
      puts "You have to select a piece."
    elsif @rows[i][j] != nil # ===========> if end position is NOT empty 
      puts "You can't move there."
    elsif @rows[x][y].vector.include?(temp_vector)
      @rows[i][j], @rows[x][y] = @rows[x][y], @rows[i][j]
    else
      puts "You can't move like that."
    end
    display_board ### !!! this needs to be moved
  end
  
  

end

