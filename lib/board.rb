# frozen_string_literal: true

# creates/modifies game board and handles game logic
class Board
  attr_reader :inactive_pieces

  def initialize
    @board_cells = Array.new(8) { Array.new(8, ' ') }
    @active_pieces = []
    @inactive_pieces = []
    @current_cell = nil
    @goal_cell = nil
    generate_pieces
  end

  def display
    # displays the game board in the terminal
    puts '  +---+---+---+---+---+---+---+---+'.light_blue
    n = 8
    while n >= 1
      puts "#{n.to_s.green} #{'|'.blue} #{cells_to_icons(@board_cells)[n - 1].join(' | '.light_blue)} #{'|'.light_blue}"
      puts '  +---+---+---+---+---+---+---+---+'.light_blue
      n -= 1
    end
    puts '    a   b   c   d   e   f   g   h'.green
  end

  def cells_to_icons(cells_array)
    # converts the cell objects to icons for displaying in the terminal
    cells_array.map do |row|
      row.map do |cell|
        case cell
        when ' '
          ' '
        else
          cell.icon
        end
      end
    end
  end

  def generate_pieces
    # creates all of the default chess pieces and places them on the board
    create_pieces
    place_pieces
  end

  def create_pieces
    # creates the required number of chess pieces, black and white
    pieces = %w[pawn knight king rook bishop queen]
    colors = %w[black white]
    pieces.each do |piece|
      n = 0
      piece_locations[piece][colors[0]].length.times do
        @active_pieces << Piece.new(piece, colors[0], piece_locations[piece][colors[0]][n])
        @active_pieces << Piece.new(piece, colors[1], piece_locations[piece][colors[1]][n])
        n += 1
      end
    end
  end

  def place_pieces
    # places each piece in its place on the board
    @active_pieces.each do |piece|
      @board_cells[piece.position[0]][piece.position[1]] = piece
    end
  end

  def piece_locations
    # stores the starting locations of each chess piece
    {
      'pawn' => { 'black' => populate_pawns([6, 0]), 'white' => populate_pawns([1, 0]) },
      'knight' => { 'black' => [[7, 1], [7, 6]], 'white' => [[0, 1], [0, 6]] },
      'king' => { 'black' => [[7, 3]], 'white' => [[0, 3]] },
      'rook' => { 'black' => [[7, 0], [7, 7]], 'white' => [[0, 0], [0, 7]] },
      'bishop' => { 'black' => [[7, 2], [7, 5]], 'white' => [[0, 2], [0, 5]] },
      'queen' => { 'black' => [[7, 4]], 'white' => [[0, 4]] }
    }
  end

  def populate_pawns(initial_position)
    # returns an array of the positions of each pawn
    locations = []
    n = 0
    while n <= 7
      locations << [initial_position[0], initial_position[1] + n]
      n += 1
    end
    locations
  end

  def move_piece(start_pos, end_pos)
    # moves a piece from one board cell to another
    set_cells(start_pos, end_pos)
    return nil unless valid_move(start_pos, end_pos)

    capture_piece(end_pos) if occupied?(end_pos)

    @board_cells[end_pos[0]][end_pos[1]] = @board_cells[start_pos[0]][start_pos[1]]
    @board_cells[start_pos[0]][start_pos[1]] = ' '
  end

  def set_cells(start_pos, end_pos)
    # sets the current contents of starting cell and ending cell
    # to the appropriate instance varible for purposes of DRY
    @current_cell = @board_cells[start_pos[0]][start_pos[1]]
    @goal_cell = @board_cells[end_pos[0]][end_pos[1]]
  end

  def occupied?(end_pos)
    # detemines if the cell is occupied by another piece
    return false if @board_cells[end_pos[0]][end_pos[1]] == ' '

    true
  end

  def capture_piece(end_pos)
    # captures an opposing color piece and makes it inactive
    @inactive_pieces << @board_cells[end_pos[0]][end_pos[1]]
  end

  def valid_move(start_pos, end_pos)
    # determines whether a given move is valid
    return nil if @current_cell == ' '

    possible_moves = calc_moves(start_pos)
    return true if possible_moves.include?(end_pos)

    false
  end

  def calc_moves(position)
    # calculates all moves for a piece from a given location
    possible_moves = []
    @current_cell.moveset.each do |direction|
      direction_array = []
      direction.each do |move|
        direction_array << [position[0] + move[0], position[1] + move[1]]
      end
      possible_moves << direction_array
    end
    filter_moves(possible_moves)
  end

  def filter_moves(possible_moves)
    wremove_off_board(remove_blocked_moves(possible_moves))
  end

  def remove_off_board(possible_moves)
    # removes any moves that go off board
    filtered_moves = []
    possible_moves.each do |move|
      filtered_moves << move if (0..7).include?(move[0]) && (0..7).include?(move[1])
    end
    filtered_moves
  end

  def remove_blocked_moves(possible_moves)
    # removes passed moves that are blocked by the position of another piece
    not_blocked = []
    possible_moves.each do |direction|
      direction.each do |move|
        cell = @board_cells[move[0]][move[1]]
        break if cell != ' ' || cell.color == @current_cell.color unless cell == ' '

        not_blocked << move
      end
    end
    not_blocked
  end
end
