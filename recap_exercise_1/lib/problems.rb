# Write a method, all_vowel_pairs, that takes in an array of words and returns all pairs of words
# that contain every vowel. Vowels are the letters a, e, i, o, u. A pair should have its two words
# in the same order as the original array. 
#
# Example:
#
# all_vowel_pairs(["goat", "action", "tear", "impromptu", "tired", "europe"])   # => ["action europe", "tear impromptu"]

def all_vowel_pairs(words)
    pairs = []
    (0...words.length - 1).each do |i|
        vowels = {"a" => 0, "e" => 0, "i" => 0, "o" => 0, "u" => 0}
        words[i].each_char {|ch| vowels[ch] += 1 if vowels.has_key?(ch)}

        (i...words.length).each do |j|
            jhash = {"a" => 0, "e" => 0, "i" => 0, "o" => 0, "u" => 0}
            words[j].each_char {|c| jhash[c] += 1 if jhash.has_key?(c)}
            jhash.merge!(vowels) {|k, a, b| a + b}

            goodmatch = true
            jhash.each_value {|v| goodmatch = false if v < 1}

            if goodmatch
                newstr = words[i] + " " + words[j]
                pairs << newstr
                break
            end

        end
    end
    pairs
end


# Write a method, composite?, that takes in a number and returns a boolean indicating if the number
# has factors besides 1 and itself
#
# Example:
#
# composite?(9)     # => true
# composite?(13)    # => false
def composite?(num)
    return false if num > -1 && num < 1
    (2...num).each {|factor| return true if num % factor == 0}
    false
end


# A bigram is a string containing two letters.
# Write a method, find_bigrams, that takes in a string and an array of bigrams.
# The method should return an array containing all bigrams found in the string.
# The found bigrams should be returned in the the order they appear in the original array.
#
# Examples:
#
# find_bigrams("the theater is empty", ["cy", "em", "ty", "ea", "oo"])  # => ["em", "ty", "ea"]
# find_bigrams("to the moon and back", ["ck", "oo", "ha", "at"])        # => ["ck", "oo"]
def find_bigrams(str, bigrams)
    bi = []
    bigrams.each {|ele| bi << ele if str.include?(ele)}
    bi
end

class Hash
    # Write a method, Hash#my_select, that takes in an optional proc argument
    # The method should return a new hash containing the key-value pairs that return
    # true when passed into the proc.
    # If no proc is given, then return a new hash containing the pairs where the key is equal to the value.
    #
    # Examples:
    #
    # hash_1 = {x: 7, y: 1, z: 8}
    # hash_1.my_select { |k, v| v.odd? }          # => {x: 7, y: 1}
    #
    # hash_2 = {4=>4, 10=>11, 12=>3, 5=>6, 7=>8}
    # hash_2.my_select { |k, v| k + 1 == v }      # => {10=>11, 5=>6, 7=>8})
    # hash_2.my_select                            # => {4=>4}
    def my_select(&prc)
        newhash = {}
        if prc
            self.each do |k, v|
                newhash[k] = v if prc.call(k, v)
            end
        else
            self.each {|k, v| newhash[k] = v if k == v}
        end
        newhash
    end
end

class String
    # Write a method, String#substrings, that takes in a optional length argument
    # The method should return an array of the substrings that have the given length.
    # If no length is given, return all substrings.
    #
    # Examples:
    #
    # "cats".substrings     # => ["c", "ca", "cat", "cats", "a", "at", "ats", "t", "ts", "s"]
    # "cats".substrings(2)  # => ["ca", "at", "ts"]
    def substrings(length = nil)
        subs = []
        self.each_char.with_index do |ch, i|
            self.each_char.with_index do |c, j|

                if length != nil
                    subs << self[i..j] if j - i + 1 == length
                else
                    subs << self[i..j] if j >= i
                end
            end
        end
        subs
    end


    # Write a method, String#caesar_cipher, that takes in an a number.
    # The method should return a new string where each char of the original string is shifted
    # the given number of times in the alphabet.
    #
    # Examples:
    #
    # "apple".caesar_cipher(1)    #=> "bqqmf"
    # "bootcamp".caesar_cipher(2) #=> "dqqvecor"
    # "zebra".caesar_cipher(4)    #=> "difve"
    def caesar_cipher(num)
        alphabet = "abcdefghijklmnopqrstuvwxyz"

        self.each_char.with_index do |ch, i|
            if ch == ch.upcase
                self[i] = alphabet[(alphabet.index(ch.downcase) + num ) % alphabet.length].upcase
            else
                self[i] = alphabet[(alphabet.index(ch) + num ) % alphabet.length]
            end
        end
        self
    end
end
