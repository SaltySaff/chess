# frozen_string_literal: true

class Game
  def initialize
    @board = Board.new
    @player_one = nil
    @player_two = nil
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
    puts 'Player 1, please enter your name:'
    choice = gets.chomp
    @player_one = Player.new(choice)
    puts 'Player 2, please enter your name:'
    choice = gets.chomp
    @player_two = Player.new(choice)
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
    place_piece while @board.board_full? == false
    drawer
  end

  def load_game
    puts 'This feature is not yet implemented.'.green
    play_again?
  end

  def player_choice
    puts 'Who wants to go first?'.green
    puts " #{'1.'.blue} #{'Red'.red}"
    puts " #{'2.'.blue} #{'Yellow'.yellow}"
    puts " #{'3.'.blue} #{'Choose for us!'.cyan}"
    player_input(1, 3)
  end

  def change_player_turn(choice)
    case choice
    when 1
      @player_turn = 'red'
    when 2
      @player_turn = 'yellow'
    when 3
      @player_turn = random_choice
    end
  end
end
