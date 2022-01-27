# frozen_string_literal: true

# creates/modifies game board
class Board
  def initialize
    @board_cells = Array.new(8) { Array.new(8, ' ') }
  end

  def display
    puts '  +---+---+---+---+---+---+---+---+'.light_blue
    n = 8
    while n >= 1
      puts "#{n.to_s.green} #{'|'.blue} #{@board_cells[n - 1].join(' | '.light_blue)} #{'|'.light_blue}"
      puts '  +---+---+---+---+---+---+---+---+'.light_blue
      n -= 1
    end
    puts '    a   b   c   d   e   f   g   h'.green
  end
end
