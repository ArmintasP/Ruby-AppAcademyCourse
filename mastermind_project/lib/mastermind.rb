require_relative "code"

class Mastermind

    def initialize(length)
        @secret_code = Code.random(length)
    end

    def print_matches(code)
        puts "Exact number of matches: #{@secret_code.num_exact_matches(code)}."
        puts "Number of near matches: #{@secret_code.num_near_matches(code)}."
    end

    def ask_user_for_guess
        print "Enter a code: "
        str = gets.chomp
        code = Code.from_string(str)
        print_matches(code)
        @secret_code == code
    end

end
