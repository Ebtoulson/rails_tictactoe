class PlayController < ApplicationController
	respond_to :html, :js

	def show
		@board = get_board
		#prevents the user from completing a game 
		#and then going to the show action and continue playing
		@completed = session[:completed]
	end

	def edit #getting the move and returning the computers move
		if request.xhr?
			load('AI.rb')
			x,y = params[:numbers].keys[0].split("")
			@board = get_board.set_move("x",x,y)
			ai = AI.new
			ai.setBoard(@board)
			if ai.checkForWinner(ai.getPositions('x'))
				#X Wins
				@message = "X Wins"
				@completed = true
				session[:completed] = true
			elsif !ai.isBoardFull?
				move = ai.getComputerMove()
				@board = get_board.set_move('o',move/3, move%3)
				ai.setBoard(@board)
				if ai.checkForWinner(ai.getPositions('o'))
					#O Wins
					@message = "O Wins"
					@completed = true
					session[:completed] = true
				end
			else
				@message = "Tie"
				@completed = true 
				session[:completed] = true
			end
			respond_to do |format|
				format.js
			end
		else
			respond_to do |format|
				format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found }
			end
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
				session[:completed] = false
			end
			return session[:board]
		end
end
