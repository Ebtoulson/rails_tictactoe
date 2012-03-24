class TicTacToe < ActiveRecord::Base
	attr_reader :board

	def initialize
		@board = [
			["", "", ""],
			["", "", ""],
			["", "", ""]
		]
	end
end
