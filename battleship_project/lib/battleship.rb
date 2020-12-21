require_relative "board"
require_relative "player"

class Battleship
    attr_reader :player, :board

    def initialize (n)
        @player = Player.new
        @board = Board.new(n)
        @remaining_misses = @board.size / 2
    end

    def start_game
        @board.place_random_ships
        print "Number of ships: "
        puts @board.num_ships
        @board.print
    end

    def lose?
        return false if @remaining_misses > 0
        puts "You lose!"
        true
    end

    def win?
        return false if @board.num_ships != 0
        puts "You win!"
        true
    end

    def game_over?
        return true if win? || lose?
        false
    end

    def turn
        @remaining_misses -= 1 if !@board.attack(@player.get_move)
        @board.print
        puts "Remaining misses: #{@remaining_misses}"
    end
end
