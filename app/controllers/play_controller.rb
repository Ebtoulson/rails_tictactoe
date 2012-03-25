class PlayController < ApplicationController
	respond_to :js

	def show
		@board = get_board
	end

	def edit #getting the move and returning the computers move
		load('AI.rb')
		x,y = params[:numbers].keys[0].split("")
		@board = get_board.set_move("x",x,y)
		ai = AI.new
		ai.setBoard(@board)
		if ai.checkForWinner(ai.getPositions('x'))
			#X Wins
			@completed = true
		elsif !ai.isBoardFull?
			move = ai.getComputerMove()
			puts "COMPUTERS MOVE #{move}"
			row = move/3
			column = move%3
			@board = get_board.set_move('o',row, column)
			ai.setBoard(@board)
			if ai.checkForWinner(ai.getPositions('o'))
				#O Wins
				@completed = true
			end
		end
		respond_to do |format|
			format.js
		end
	end

	def new
		session[:board] = nil
		session[:completed] = false
		redirect_to :action => 'show'
	end

	private

		def get_board
			if session[:board] == nil
				session[:board] = TicTacToe.new
			end
			return session[:board]
		end
end
