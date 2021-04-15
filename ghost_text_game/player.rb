class Player
    attr_reader :name
    def initialize(name)
        @name = name
    end

    def guess(string, *dump)
        puts "Enter a letter for the current fragment: \"#{string}\". "
        gets.chomp.downcase
    end

    def alert_invalid_guess(char)
        puts "\'#{char}\' is an invalid letter or it cannot be added to a new fragment."
        puts "You must enter an alphabet letter.\n"
    end
end

class AIPlayer
    attr_reader :name
    def initialize(name, dict_name)
        strings = File.read(dict_name).split
        @dictionary = Set.new(strings)
        @name = name
    end

    def guess(string, count)
        num = -1
        letter = nil
        longest_word = 0
        losing_letter = nil
        abc = Set.new(('a'..'z').to_a.shuffle)

        abc.each do |char|
            frag = string + char
            winning_move = true

            @dictionary.each do |dict_word|
                remaining_letters = dict_word.length - frag.length

                if (dict_word.start_with?(frag)) 
                    if (remaining_letters % count > 0 && remaining_letters > 0)
                        num = remaining_letters % count
                        letter = char
                    elsif (remaining_letters % count == 0)
                        winning_move = false
                        losing_letter = char
                        break
                    elsif (remaining_letters % count >= num && longest_word < dict_word.length)
                        longest_word = dict_word.length
                        winning_move = false
                        num = remaining_letters % count
                        letter = char
                    end
                else
                    winning_move = false
                end
            end
            return letter if winning_move
        end
        return losing_letter if letter == nil
        return letter if @dictionary.any?{|dict| dict.start_with?(string + letter)}
        losing_letter
    end

    def alert_invalid_guess(char)
        puts "\'#{char}\' is an invalid letter or it cannot be added to a new fragment."
        puts "You must enter an alphabet letter.\n"
    end

end