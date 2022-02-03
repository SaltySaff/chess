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

  def greeting
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
    change_color(choice)
    clear_delay
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
  end

  def player_input(min, max)
    loop do
      user_input = gets.chomp
      verified_number = verify_input(min, max, user_input.to_i) if user_input.match?(/^\d$/)
      return verified_number if verified_number

      puts "Input error! Please enter a number between #{min} and #{max}."
    end
  end

  def verify_input(min, max, input)
    return input if input.between?(min, max)
  end

  def new_game
    create_players
    choice = player_choice
    change_player_turn(choice)
    clear
    place_piece
  end

  def load_game
    puts 'This feature is not yet implemented.'.green
    play_again?
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

  def place_piece
    @board.display
    puts "#{'It\'s'.green} #{display_player_color(@player_turn)}#{'\'s turn to place a piece'.green}"
    puts 'Please choose a column to place your piece in.'.cyan
    choice = validate_placement(player_input(1, 7))
    @board.add(@player_turn, choice)
    check_for_victory(@player_turn, choice)
    switch_turn
  end

  def clear
    system 'clear'
  end

  def clear_delay
    sleep(1)
    system 'clear'
  end
end
