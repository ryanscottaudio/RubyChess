require 'byebug'
require 'colorize'
require_relative 'lib/keypress'
require_relative 'lib/game'
require_relative 'lib/piece'
require_relative 'lib/stepping_piece'
require_relative 'lib/sliding_piece'
require_relative 'lib/king'
require_relative 'lib/queen'
require_relative 'lib/bishop'
require_relative 'lib/knight'
require_relative 'lib/rook'
require_relative 'lib/pawn'
require_relative 'lib/player'
require_relative 'lib/board'

if __FILE__ == $PROGRAM_NAME

  Game.new("White", "Black")

end
