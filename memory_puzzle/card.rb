class Card

    attr_reader :value, :hidden

    def initialize(value)
        @value = value
        @hidden = true
    end

    def reveal
        @hidden = false
    end

    def hide
        @hidden = true
    end

    def ==(other)
        self.value == other.value
    end

    def to_s
        return @value if @hidden == false
        return " "
    end
end