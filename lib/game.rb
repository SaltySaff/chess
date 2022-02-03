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
end
