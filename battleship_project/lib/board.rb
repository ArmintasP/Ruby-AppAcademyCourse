class Board

    attr_reader :size


    def self.print_grid(grid)
        grid.each {|arr| puts arr.join(" ")}
    end

    def initialize(n)
    @grid = Array.new(n) {Array.new(n, :N)}
    @size = @grid.flatten.count
    end


    def [](arr)
        @grid[arr[0]][arr[1]]
    end

    def []=(pos, val)
        @grid[pos[0]][pos[1]] = val
    end

    def num_ships
        @grid.flatten.count(:S)
    end

    def attack(pos)
        if self[pos] == :S
            self[pos] = :H
            puts "You sunk my battleship!"
            true
        else
            self[pos] = :X
            false
        end
    end

    def place_random_ships
        while @grid.flatten.count(:S) < @grid.flatten.length * 0.25
            @grid[rand(@grid.length)][rand(@grid.length)] = :S
        end
    end

    def hidden_ships_grid
        newarr = @grid.map do |arr|
            narr = []
            arr.each do |ele|
                if ele == :S
                    narr << :N
                else
                    narr << ele
                end
            end
            narr
        end
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
        Board.print_grid(hidden_ships_grid)
    end

end
