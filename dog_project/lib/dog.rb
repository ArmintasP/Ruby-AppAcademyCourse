class Dog
    def initialize(name, breed, age, bark, favorite_foods)
        @name = name
        @breed = breed
        @age = age
        @bark = bark
        @favorite_foods = favorite_foods
    end

    def name
        @name
    end

    def breed
        @breed
    end

    def age
        @age
    end

    def age=(num)
        @age = num
    end

    def bark
        return @bark.upcase if @age > 3
        @bark.downcase
    end

    def favorite_foods
        @favorite_foods
    end

    def favorite_food?(string)
        foods = @favorite_foods.map {|ele| ele.downcase}
        foods.include?(string.downcase)
    end

end
