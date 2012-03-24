class PlayController < ApplicationController
	def play
		@board = TicTacToe.new
	end
end
