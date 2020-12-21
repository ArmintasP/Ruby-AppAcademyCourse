# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.

def largest_prime_factor(num)
    lnum = nil
    (2..num).each do |factor|
        if num % factor == 0 && prime?(factor)
            lnum = factor
        end
    end
    lnum
end

def prime?(num)
    return false if num < 2

    (2...num).each do |factor|
        if num % factor == 0
            return false
        end
    end
    true
end

def unique_chars?(str)
    hash = Hash.new(0)
    str.each_char do |ch|
        hash[ch] += 1
    end
    hash.each_value {|v| return false if v > 1}
    true
end

def ana_array(arr_1, arr_2)
    hash1 = Hash.new(0)
    hash2 = Hash.new(0)
    arr_1.each do |ele|
        hash1[ele] += 1
    end
    arr_2.each do |ele|
        hash2[ele] += 1
    end
    return true if hash1 == hash2
    false
end


def dupe_indices(arr)
    hash = Hash.new([])
    arr.each_with_index do |ele, i|
        hash[ele] += [i]
    end
    hash = hash.select {|k, v| v.length > 1}
end