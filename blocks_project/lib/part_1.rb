def select_even_nums(arr)
    arr.select(&:even?)
end

def reject_puppies(arr)
    arr.reject {|ele| ele["age"] <= 2}
end

def count_positive_subarrays(arr)
    arr.count {|ele| ele.sum > 0}
end

def aba_translate(str)
    vowels = "aeiou"
    newstr = ""
    str.each_char do |ch|
        if vowels.include?(ch)
            newstr += ch + "b" + ch.downcase
        else
            newstr += ch
        end
    end
    newstr
end

def aba_array(arr)
    arr.map {|ele| aba_translate(ele)}
end