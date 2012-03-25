class TicTacToe < ActiveRecord::Base
	attr_accessor :board, :completed

	def initialize
		@board = [
			['','',''],
			['','',''],
			['','','']
		]
		@completed = false
	end

	def at(x,y)
		return @board[x][y]
	end

	def set_move(character, x, y)
		@board[x.to_i][y.to_i] = character.to_s
		return @board
	end
end
