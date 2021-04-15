require_relative 'card'
class Board
    attr_reader :rows, :cols

    SIZE = 18
    def initialize()
        @cards = Array.new
        @rows = Math.sqrt(SIZE * 2)
        @cols = Math.sqrt(SIZE * 2)    
    end

    def populate
        letter = ('A'..'Z').to_a + ('a'..'z').to_a
        letter.shuffle
        (0...SIZE).each do |i|
            @cards.push(Card.new(letter[i]))
            @cards.push(Card.new(letter[i]))
        end
        @cards = @cards.shuffle
    end

    def render

        col_string = " "
        (0...@cols).each do |num|
            col_string << ' ' + num.to_s
        end

        puts col_string
        (0...@rows).each do |row|
            row_string = row.to_s

            (0...@cols).each do |col|
                row_string += " " + @cards[row * @rows + col].to_s 
            end

        puts row_string 
        end
    end

    def won?
        @cards.each do |card|
            return false if card.hidden == true
        end
        true
    end
    
    def hide(guessed_pos)
        card = @cards[guessed_pos]
        card.hide
    end

    def reveal(guessed_pos)
        card = @cards[guessed_pos]
        return nil if card.hidden == false
        
        card.reveal
        card.value
    end


end
