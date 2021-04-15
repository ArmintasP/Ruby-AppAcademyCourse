require 'set'
require_relative 'player'
class Ghost

    ABC = Set.new("a".."z")
    MAX_LOSS = 5
    def initialize(dict_name, *players)
        strings = File.read(dict_name).split
        @dictionary = Set.new(strings)
        @players = players
        @losses = Hash.new {|hash, player| hash[player] = 0}
    end

    
    def run
        while (!self.game_end?)
            self.play_round
        end
        puts "#{self.winner.name} won the game!"
    end

    def play_round
        @fragment = ""
        self.announcement

        while(!round_end?)
            self.take_turn
            self.next_player!
        end

        self.update_stats
    end


    def update_stats
        player = self.previous_player
        
        puts "#{player.name} lost this round by completing: #{@fragment}!"

        @losses[player] += 1

        puts "#{player.name} lost the game!" if @losses[player] == MAX_LOSS
    end

    def round_end?
        @dictionary.include?(@fragment)
    end

    def current_player
        @players[0]
    end

    def previous_player
        (@players.length - 1).downto(0) do |i|
            return @players[i] if @losses[@players[i]] < MAX_LOSS
        end
    end

    def next_player!
        @players.push(@players.shift)
        while !(@losses[self.current_player] < MAX_LOSS)
            @players.push(@players.shift)
        end
    end

    def take_turn
        puts "#{self.current_player.name} has to make a turn."
        char = nil
        while (char == nil)
            char = self.current_player.guess(@fragment, self.remaining_players)
            
            if !valid_play?(char)
                self.current_player.alert_invalid_guess(char)
                char = nil
            end
        end

        @fragment += char
        puts "#{self.current_player.name} added a new letter '#{char}' to the fragment.\n"
        puts "---------------------"
    end

    def valid_play?(char)
        return false if !ABC.include?(char)

        new_frag = @fragment + char

        @dictionary.any?{|dict| dict.start_with?(new_frag)}
    end

    def announcement
        puts "---------------------"
        puts "Current status:"
        @players.each {|player| puts "#{player.name}: #{self.record(player)}"}
        puts "---------------------"
        puts "Let the round begin!\n\n"
    end

    def record(player)
        string = "GHOST"
        num = @losses[player]
        return "" if num == 0
        string[0...num]
    end

    def game_end?
        return true if self.remaining_players == 1
        false
    end

    def remaining_players
        count = @losses.count {|h, v| v < MAX_LOSS}
    end

    def winner
        @losses.each_pair do |player, val|
            return player if val < MAX_LOSS
        end
    end
end

if $PROGRAM_NAME == __FILE__
    game = Ghost.new("dictionary.txt", Player.new("You"), AIPlayer.new("Bot2", "dictionary.txt"), AIPlayer.new("Bot3", "dictionary.txt"))
    game.run  
end
