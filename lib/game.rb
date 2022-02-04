# frozen_string_literal: true

class Game
  def initialize
    @board = Board.new
    @player_one = nil
    @player_two = nil
    @player_turn = nil
  end

  def play_game
    greeting
    choice = player_input(1, 2)
    case choice
    when 1
      new_game
    when 2
      load_game
    end
  end

  def save_game
    game_state = YAML.dump({
      board: @board,
      player_one: @player_one,
      player_two: @player_two,
      player_turn: @player_turn
    })
    File.open('./chess.yml', 'w') { |f| f.write game_state }
    exit
  end

  def load_game
    yaml = YAML.load_file('./chess.yml')
    deserialize(yaml)
    prompt_placement
  end

  def deserialize(file)
    @board = file[:board]
    @player_one = file[:player_one]
    @player_two = file[:player_two]
    @player_turn = file[:player_turn]
  end

  def continue_or_save
    puts 'Would you like to continue or save?'.green
    puts " #{'1.'.blue} #{'Continue'.cyan}"
    puts " #{'2.'.blue} #{'Save'.cyan}"
    answer = player_input(1, 2)
    case answer
    when 1 then prompt_placement
    when 2 then save_game
    end
  end

  def greeting
    clear
    puts 'Welcome to Chess!'.green
    puts " #{'1.'.blue} #{'New Game'.cyan}"
    puts " #{'2.'.blue} #{'Load Game'.cyan}"
    puts " #{'3.'.blue} #{'Exit'.cyan}"
  end

  def create_players
    clear
    puts 'Player 1, please enter your name:'.cyan
    choice = gets.chomp
    @player_one = Player.new(choice)
    clear
    puts 'Player 2, please enter your name:'.cyan
    choice = gets.chomp
    @player_two = Player.new(choice)
    choose_color(@player_one)
    clear
  end

  def choose_color(player)
    clear
    puts "What color would you like to be #{player.name}?".cyan
    puts " #{'1.'.blue} #{'White'.white}"
    puts " #{'2.'.blue} #{'Black'.magenta}"
    choice = player_input(1, 2)
    clear
    change_color(choice)
  end

  def change_color(choice)
    case choice
    when 1
      @player_one.color_choice = 'white'
      @player_two.color_choice = 'black'
      puts "#{@player_one.name} is white.".white
      puts "#{@player_two.name} is black.".magenta
    when 2
      @player_one.color_choice = 'black'
      @player_two.color_choice = 'white'
      puts "#{@player_one.name} is black.".magenta
      puts "#{@player_two.name} is white.".white
    end
    clear_delay(1.5)
  end

  def player_input(min, max)
    loop do
      user_input = gets.chomp
      verified_number = verify_input(min, max, user_input.to_i) if user_input.match?(/^\d$/)
      return verified_number if verified_number

      puts "Input error! Please enter a number between #{min} and #{max}.".red
    end
  end

  def verify_input(min, max, input)
    return input if input.between?(min, max)
  end

  def player_input_letter(min, max)
    loop do
      user_input = gets.chomp.downcase
      verified_letter = verify_letter(user_input, min, max) if user_input.match?(/^[a-z]$/)
      return verified_letter if verified_letter

      puts "Input error! Please enter a letter between '#{min}' and '#{max}'.".red
    end
  end

  def verify_letter(letter, min_letter, max_letter)
    return letter if (min_letter..max_letter).include?(letter)
  end

  def new_game
    create_players
    choice = player_choice
    change_player_turn(choice)
    clear
    prompt_placement
  end

  def player_choice
    puts 'Who wants to go first?'.green
    puts " #{'1.'.blue} #{display_player_color(@player_one)}"
    puts " #{'2.'.blue} #{display_player_color(@player_two)}"
    puts " #{'3.'.blue} #{'Choose for us!'.cyan}"
    player_input(1, 3)
  end

  def display_player_color(player)
    return player.name.magenta if player.color_choice == 'black'

    player.name.white
  end

  def change_player_turn(choice)
    case choice
    when 1
      @player_turn = @player_one
    when 2
      @player_turn = @player_two
    when 3
      @player_turn = random_choice
    end
  end

  def random_choice
    random_number = rand(1..2)
    case random_number
    when 1
      @player_one
    when 2
      @player_two
    end
  end

  def prompt_placement
    until @board.check_counter == 2
      clear_with_board
      puts "#{'It\'s'.green} #{display_player_color(@player_turn)}#{'\'s turn to place a piece'.green}"
      place_piece
      switch_turn
      clear_with_board
      continue_or_save
    end
    clear_with_board
    puts 'Checkmate!'.yellow
    play_again
  end

  def play_again
    puts 'Would you like to play again?'.blue
    puts " #{'1.'.blue} #{'Play again'.cyan}"
    puts " #{'2.'.blue} #{'Return to the main menu'.cyan}"
    choice = player_input(1, 2)
    case choice
    when 1
      new_game
    when 2
      play_game
    end
  end

  def place_piece
    piece = validate_choice(choose_piece)
    destination = validate_destination(choose_destination, piece)
    @board.move_piece(piece, destination)
  end

  def validate_choice(piece)
    return empty_tile if @board.get_piece(piece) == ' '

    return wrong_color if @board.get_piece(piece).color != @player_turn.color_choice

    piece
  end

  def validate_destination(destination, piece)
    return placement_error if @board.move_piece(piece, destination) == false

    destination
  end

  def empty_tile
    puts 'Oops! There isn\'t one of your pieces there!'.red
    clear_with_board(2)
    place_piece
  end

  def placement_error
    puts 'Oops! You can\'t place that piece there. Please choose another tile.'.red
    clear_with_board(2)
    place_piece
  end

  def wrong_color
    puts 'Oops! That piece doesn\'t belong to you!'.red
    clear_with_board(2)
    place_piece
  end

  def switch_turn
    @player_turn = @player_turn == @player_one ? @player_two : @player_one
  end

  def choose_piece
    clear_with_board(2)
    puts 'First we\'ll choose a piece...'.green
    clear_with_board(2)
    coords
  end

  def choose_destination
    puts 'Where would you like to move the piece to?'.green
    clear_with_board(2)
    coords
  end

  def validate_move(start_coords, end_coords)
    loop do
      verified_number = verify_input(min, max, user_input.to_i) if user_input.match?(/^\d$/)
      return verified_number if verified_number

      puts "Input error! Please enter a number between #{min} and #{max}.".red
    end
  end

  def letter_to_number(letter)
    # converts input letter to appropriate index number
    letter_to_number = ('a'..'h').zip(0..7).to_h
    letter_to_number[letter]
  end

  def coords
    puts 'Please enter a column letter:'.green
    x_axis = letter_to_number(player_input_letter('a', 'h'))
    puts 'Please enter a row number:'.green
    y_axis = player_input(1, 8) - 1
    clear_with_board
    [y_axis, x_axis]
  end

  def clear
    system 'clear'
  end

  def clear_delay(delay)
    sleep(delay)
    system 'clear'
  end

  def clear_with_board(delay = 0)
    # clears the screen without removing the board
    sleep(delay)
    system 'clear'
    @board.display
    puts 'Check!'.yellow if @board.check_counter == 1
  end

  def setup
    @board = CFBoard.new
    @player_turn = nil
  end
end
