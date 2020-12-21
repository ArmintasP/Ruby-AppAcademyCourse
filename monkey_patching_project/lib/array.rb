# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
    def span
        return self.max - self.min if !self.empty?
    end

    def average
        self.sum * 1.0 / self.length if !self.empty?
    end

    def median
        arr = self.sort
        return nil if arr.empty?
        return arr[arr.length / 2 ] if arr.length % 2 == 1
        
        (arr[arr.length / 2] + arr[arr.length / 2 - 1]) / 2.0
    end

    def counts
        hash = Hash.new(0)
        self.each {|ele| hash[ele] += 1}
        hash
    end

    def my_count(val)
        count = 0
        self.each {|ele| count += 1 if ele == val}
        count
    end

    def my_index(val)
        (0...self.length).each {|i| return i if self[i] == val}
        return nil
    end

    def my_uniq
        newarr = []
        self.each {|ele| newarr << ele if !newarr.include?(ele)}
        newarr
    end

    def my_transpose
        newarr = []
        self.each_with_index do |arr, i|
            if i == 0
                arr.each {|el| newarr << [el]}
            else
                arr.each_with_index do |ele, j|
                    newarr[j] << ele
                end
            end
        end
        newarr
    end
end
