class Room
    def initialize(number)
        @capacity = number
        @occupants = []
    end

    def capacity
        @capacity
    end

    def occupants
        @occupants
    end

    def full?
        return true if @occupants.length == @capacity
        false
    end

    def available_space
       @capacity - @occupants.length
    end

    def add_occupant(str)
        if !full?
            @occupants << str
            return true
        else
            return false
        end
    end


end
