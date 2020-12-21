def reverser(str, &prc)
    prc.call(str.reverse)
end

def word_changer(str, &prc)
    words = str.split(" ")
    (0...words.length).each { |i| words[i] = prc.call(words[i])}
    words.join(" ")
end

def greater_proc_value(num, prc1, prc2)
    return prc1.call(num) if prc1.call(num) > prc2.call(num)
    return prc2.call(num)
end

def and_selector(arr, prc1, prc2)
    newarr = []
    arr.each {|ele| newarr << ele if prc1.call(ele) && prc2.call(ele)}
    newarr
end

def alternating_mapper(arr, prc1, prc2)
    newarr = []
    (0...arr.length).each do |i|
        if i % 2 == 0
            newarr << prc1.call(arr[i])
        else
            newarr << prc2.call(arr[i])
        end
    end
    newarr
end