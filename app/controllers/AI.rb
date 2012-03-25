class AI
	@@wins = [
		[0,1,2],
		[3,4,5],
		[6,7,8],
		[0,4,8],
		[2,4,6],
		[0,3,6],
		[1,4,7],
		[2,5,8]
	]

	@@corners = [0,2,6,8]
	@@sides = [1,3,5,7]

	@board = []

	#global setter for the value board 
	def setBoard(game_board)
		@board = [
			game_board[0][0], game_board[0][1], game_board[0][2],
			game_board[1][0], game_board[1][1], game_board[1][2], 
			game_board[2][0], game_board[2][1], game_board[2][2]
		]
	end

	#checks to see if all positions are taken
	def isBoardFull?
		(0..8).each do |i|
			if @board[i].empty?
				return false
			end
		end
		true
	end

	def getPositions(letter)
		positions = []
		@board.each_with_index { |value, index| 
			if value == letter
				positions << index
			end
		}
		return positions
	end

	def checkForWinner(positions)
		@@wins.each do |x|
			if (x&positions).length == 3
				return true
			end
		end
		return false
	end

	#AI logic used to determine each move
	def getComputerMove()
		comp = getPositions('o')
		person = getPositions('x')
		#checks for the first move, if the first move is
		#in the center then the computer must pick a corner
		if person.length == 1
			first_move = person.pop
			if first_move == 4
				return 0
			else 
				return 4
			end
		else
			#winning move
			@@wins.each do |x|
				if (x&comp).length == 2
					index = (x-comp).pop
					if @board[index] == ''
						return index
					end
				end
			end
			#blocking move
			@@wins.each do |x|
				if (x&person).length == 2
					puts "BLOCK AT? #{x&person} *****"
					index = (x-person).pop
					if @board[index] == ''
						puts "BLOCKED #{index}"
						return index
					end
				end
			end
			#checks to make sure the computer doesn't pick a 
			#corner if the user already possesses two corners
			if (@@corners-person).length <= 2
				[4,1,3,5,7].each do |index|
					if @board[index] == ''
						return index
					end
				end
			end
			#prevents forking by blocking off the sides if the
			#user picks the sides
			(@@sides&person).each do |x|
				#just checking to make sure they are both empty
				#because a block would have already stopped them
				#if two 'o's lined up
				if x == 1 or x == 7
					if @board[x+1] == '' and @board[x-1] == ''
						return x+1
					end
				elsif @board[x-3] == '' and @board[x+3] == ''
					return x+3
				end
				[4,0,2,6,8,1,3,5,7].each do |index|
					if @board[index] == ''
						return index
					end
				end
			end
		end
	end
end
