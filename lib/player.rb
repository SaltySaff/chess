# frozen_string_literal: true

class Player
  attr_accessor :name

  def initialize(name)
    @name = name
    @captured_pieces = []
  end
end
