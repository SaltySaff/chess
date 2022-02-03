# frozen_string_literal: true

class Player
  attr_accessor :name, :color_choice

  def initialize(name)
    @name = name
    @captured_pieces = []
    @color_choice = nil
  end
end
