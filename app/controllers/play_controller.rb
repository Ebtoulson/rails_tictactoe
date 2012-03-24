class PlayController < ApplicationController
	respond_to :js

	def show
		@board = get_board
	end

	def edit #getting the move and returning the computers move
		x,y = params[:numbers].keys[0].split("")
		@board = get_board.set_move("x",x,y)
		respond_to do |format|
			format.js
		end
	end

	def new
		session[:board] = nil
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
