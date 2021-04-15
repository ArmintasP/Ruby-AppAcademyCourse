require_relative 'board'
require_relative 'player'

class Game
    def initialize(player)
        @board = Board.new
        @previous_guess = nil
        @previous_value = nil
        @player = player
    end

    def play
        @board.populate
        @player.pass_info(@board)

        until self.over?
            pos = @player.get_pos(@previous_guess)
            self.make_guess(pos)

            pos = @player.get_pos(@previous_guess)
            self.make_guess(pos)
        end

        @player.print_board
        puts "Congratulations, you've won the game!"
    end


    def make_guess(pos)

        if @previous_guess == nil
            @previous_guess = pos 
            @previous_value = @board.reveal(pos)

            while @previous_value == nil
                self.print_unhidden_card
                
                @previous_guess = nil
                pos = @player.get_pos(@previous_value)
                @previous_guess = pos 
                @previous_value = @board.reveal(pos)
            end
            @player.receive_revealed_card(pos, @previous_value)
            return

        else
            value = @board.reveal(pos)
            
            while value == nil
                self.print_unhidden_card
                pos = @player.get_pos(@previous_guess)
                value = @board.reveal(pos)
            end
            @player.receive_revealed_card(pos, value)
            @player.print_board

            if value != @previous_value
                self.match_failure(pos)
            else
                @player.receive_match(@previous_guess, pos)
                self.match_success
            end

            @previous_guess = nil
        end

    end

    def print_unhidden_card
        puts "The position you've given has already unflipped card!"
        sleep(2)
    end

    def match_failure(pos)
        puts "Failed! Try again"
        sleep(2)

        @board.hide(@previous_guess)
        @board.hide(pos)        
    end

    def match_success
        puts "Success! It's a match!"
        sleep(2)
    end

    def over?
        @board.won?
    end
end

game = Game.new(AIPlayer.new)
game.play