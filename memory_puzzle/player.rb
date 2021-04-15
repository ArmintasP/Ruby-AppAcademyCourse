class HumanPlayer
    def initialize
        
    end

    def pass_info(board)
        @board = board
    end


    def get_pos(previous_guess)
        @previous_guess = previous_guess
        self.prompt

        pos = self.collect_input

        while (pos == nil)
            sleep(2)
            self.prompt
            pos = self.collect_input
        end

        pos
    end 
    

    def collect_input
        pos = gets.chomp
        
        self.print_board

        unless pos.match(/^\d+\s*,\s*\d+$/)
            puts "The position should be in this format: row, column. For example, '1, 2;"
            return nil
        end

        pos = pos.split(',')
        pos[0] = pos[0].to_i
        pos[1] = pos[1].to_i

        final_pos = pos[0] * @board.rows + pos[1]

        if pos[0] >= @board.rows || pos[1] >= @board.cols
            puts "Such position does not exist!"
            return nil
        elsif final_pos == @previous_guess
            puts "Plese enter different position from previous!"
            return nil
        end

        final_pos
    end

    def prompt
        self.print_board
        puts "Please enter the position of a card that you'd like to flip, for example, '1, 2'"
    end
    
    def print_board
        system("clear")
        @board.render
    end

    
    def receive_revealed_card(pos, val)
    end

    def receive_match(pos1, pos2)
    end
end


class AIPlayer
    def initialize
        @known_cards = Hash.new
        @matched_cards = Array.new
    end

    def pass_info(board)
        @board = board
        @pos_list = Array.new
        (0...@board.rows * @board.cols).each {|num| @pos_list << num}
        @pos_list = @pos_list.shuffle
    end

    def get_pos(previous_guess)
        self.print_board

        if previous_guess == nil
            return self.calculate_first_guess
        else
            return self.calculate_second_guess(previous_guess)
        end

    end

    def calculate_first_guess
        pos = nil
        @known_cards.each_key do |key1|
            @known_cards.each_key do |key2|
                next if key1 == key2
                if @known_cards[key1] == @known_cards[key2]
                    pos = key1
                    break
                end
            end
            return pos if pos != nil
        end

        return @pos_list[0]
    end

    def calculate_second_guess(previous_guess)
        value = @known_cards[previous_guess]

        @known_cards.each_key do |key|
            next if key == previous_guess
            if @known_cards[key] == value
                return key
            end
        end

        return @pos_list[0]
    end

    def receive_revealed_card(pos, val)
        @known_cards[pos] = val
        @pos_list.delete(pos)
    end

    def receive_match(pos1, pos2)
        @matched_cards << pos1 << pos2
        @known_cards.delete(pos1)
        @known_cards.delete(pos2)
        @pos_list.delete(pos1)
        @pos_list.delete(pos2)
    end

    def print_board
        system("clear")
        @board.render
    end
end