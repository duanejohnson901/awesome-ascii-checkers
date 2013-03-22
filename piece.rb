
class Piece
	attr_reader :position, :color

	def initialize(color, position, board, king = false)
		@color = color
		@position = position
		@board = board
		@king = king
	end

	def implode
		@board[@position] = nil
		@position = nil
	end

	def move_to(coord)
		@king = true if coord[0] == king_me
		@board[coord] = self
		@board[@position] = nil
		@position = coord
	end

	def forward
		@color == :red ? 1 : -1
	end

	def moves
		deltas = possible_deltas
		deltas.select! { |delta| @board.in_bounds?( @position.zip(delta) ) }#[delta[0] + position[0], delta[1] + position[1]]) }
		moves = []
		deltas.each do |delta|
			moves += get_moves_for_delta(delta, @position, @color)
		end

		moves
	end

	def possible_deltas
		f = forward
		@king ? [[f, 1], [f, -1], [-f, 1], [-f, -1]] : [[f, 1], [f, -1]]
	end

	def get_moves_for_delta(delta, position, my_color) ###what is going on here? i recursively call a method
		moves = []										##that lives inside this instance of class  
														##does the new frame include instance variables from the caller object??
		move_to = @position.zip(delta)#[@position[0] + delta[0], @position[1] + delta[1]]
		if @board[move_to] != nil && @board[move_to].color != my_color  ##enemy, is there, try skipping over
			moves += get_moves_for_delta(delta.map { |i| 2*i }, position, my_color)
		elsif @board[move_to] == nil
			moves << move_to## nothing is there
		end
		moves
	end

	def king_me
		@color == :red ? 7 : 0
	end

	def render
		piece = @color == :red ? "R " : "B "
		piece.colorize(@color)
	end
end