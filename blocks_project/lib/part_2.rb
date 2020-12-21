def all_words_capitalized?(arr)
    arr.all? {|ele| ele[0] == ele[0].upcase && ele[1..-1] == ele[1..-1].downcase}
end

def no_valid_url?(arr)
    arr.none? {|ele| ele.end_with?(".com", ".net", ".io", ".org")}
end

def any_passing_students?(arr)
    arr.any? {|ele| ele[:grades].sum / ele.length >= 75}
end