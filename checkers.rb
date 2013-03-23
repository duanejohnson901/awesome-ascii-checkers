require 'colorize'
require 'debugger'
require './piece.rb'
require './board.rb'
require './player.rb'



class Game

	attr_reader :board

	def initialize
		@players = [HumanPlayer.create(:black, 1, self), HumanPlayer.create(:red, 2, self)]
		@board = Board.new(@players[0], @players[1])
		@players.each { |player| player.make_team }

		###test code :)
		@test_moves = ["22,33","51,40","11,22","57,46","33,44","62,51","20,31","46,37","00,11","66,57",
						"11,20","55,33","31,42","33,11","20,31","11,00"]
 
		@board.place_pieces ##?? is there a better way to deal with mutually dependent class creation
		play									### probably to avoid it...		
	end

	def play
		still_my_turn = false #### HAAX
		until won?
			still_my_turn = one_turn(still_my_turn)
		end
	end

	def won?
		##stub
		false
	end

	def one_turn(still_my_turn)
		puts "Welcome to Checkers"
		puts "___________________"

		@players.each do |player|
			if still_my_turn
				still_my_turn = false
				next
			end
			show_board
			#start test code
			do_a_test_move(player)
			sleep(0.5)
			#real code
			#still_my_turn = @board.make_move(player.take_turn)
		end
		still_my_turn
	end

	def do_a_test_move(player)
		debugger
		move = @test_moves.shift
		@board.make_move(player.get_move(move))
	end

	def show_board
		puts
		@board.matrix.each_with_index do |row, i|
			row.each_with_index do |square, j|
				print @board.render( [i, j] )
			end
			puts
		end
	end
end

g = Game.new
