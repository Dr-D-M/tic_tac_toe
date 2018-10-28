#board for the game

class GameOn
	attr_accessor :square, :finish_game
	def initialize 
		@square = [" ", " ", " ", " ", " ", " ", " ", " ", " ",]
		@player_human1 = Player.new("Player human 1", "X")
		@player_human2 = Player.new("Player human 2", "O")
		@current_player = @player_human1
		@end_game
	end
	def instructions
		puts "Look at the squares and select a number: "
		puts "1|2|3"
		puts "4|5|6"
		puts "7|8|9"
		puts "\n"
	end
	def board_game
		puts "\nBoard:"
		puts "\n #{@square[0]} | #{@square[1]} | #{@square[2]}"
		puts "-----------"
		puts "\n #{@square[3]} | #{@square[4]} | #{@square[5]}"
		puts "-----------"
		puts "\n #{@square[6]} | #{@square[7]} | #{@square[8]}"
	end
    def user_name
        puts "What's your name?"
   	    @user = gets.chomp	
   	    puts "Lets play #{@user}"
    end
	def change_player
		@current_player == @player_human1 ? @current_player = @player_human2 : @current_player = @player_human1
	end
	def ok_computer
		input = "O" "X" 

	end
   def player_input
   	
   	puts "Your turn #{@user}. Follow instructions!"
   	input= gets.chomp.to_i
   	until input.between?(1, 9)
   		puts "You need to type a number between 1 - 9. Check the instructions!"
   		input = gets.chomp.to_i
   	end
   	input - 1
   end
   def player_choice
   	move = player_input
   	until @square[move] == " "
   		puts "This place has been taken, pal!"
   		move = player_input
   end
   @square[move] = @current_player.symbol
   @current_player.taken_cells << move
   end

   def check_end_game
   	conditions = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
   	  conditions.each do |condition|
   	  	if (condition - @current_player.taken_cells).empty?
   	  		puts "#{@current_player} wins!"
   	  		@end_game = true
   	  	end
   	  end
   	  if @player_human1.taken_cells.size + @player_human2.taken_cells.size >= 9
   	  	puts "It's a draw."
   	  	@end_game = true
   	  end
   	  @end_game
   	end
   end

	class Player
		attr_accessor :symbol, :taken_cells, :name
		def initialize(name, symbol)
			@name = name
			@symbol = symbol
			@taken_cells = []
	end
	end

play = GameOn.new
play.user_name
play.instructions
until play.check_end_game
	play.player_choice
	play.board_game
	play.check_end_game
	play.change_player
end
