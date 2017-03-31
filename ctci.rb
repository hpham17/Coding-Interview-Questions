require 'set'
require 'benchmark'
require 'test/unit'
extend Test::Unit::Assertions
# 1.1 Implement an algorithm to determine if a string has all unique characters. What if you can not use additional data structures?

def string_unique?(str)
  unique = Set.new
  str.each_char do |s|
    if unique.include? s
      return false
    else
      unique.add s
    end
  end
  true
end

# Without Data structures
# for each char in str
#   for each char1 in str
#     if char != char
#       if char == char1
#         return false

def string_uniq?(str)
  str.each_char.with_index do |s, index|
    str.each_char.with_index do |c, index2|
      if index != index2
        return false if s == c
      end
    end
  end
  true
end


# high level overview: use a bit var 0b0 and "XOR"
# with an 0b01 shifted over by its ascii code - 97
def string_uniq_faster?(str)
  uniq = 0b0
  str.each_char do |c|
    one = 0b1
    if uniq ^ (one << c.ord - 97) < uniq
      return false
    else
      uniq = uniq ^ (one << c.ord - 97)
    end
  end
  true
end

string1 = "abc"
string2 = "abcdefghijklmnopqrstuvwxyz"
duplicate1 = "aaaaa"
duplicate2 = "abcdefghijklmnopqrstuvwxyza"


Benchmark.bm(1) do |bm|
  bm.report('string_unique?') do
    assert_equal string_unique?(string1), true
    assert_equal string_unique?(string2), true
    assert_equal string_unique?(duplicate1), false
    assert_equal string_unique?(duplicate2), false
  end

  bm.report('string_uniq?') do
    assert_equal string_uniq?(string1), true
    assert_equal string_uniq?(string2), true
    assert_equal string_uniq?(duplicate1), false
    assert_equal string_uniq?(duplicate2), false
  end
  bm.report('string_uniq_faster?') do
    assert_equal string_uniq_faster?(string1), true
    assert_equal string_uniq_faster?(string2), true
    assert_equal string_uniq_faster?(duplicate1), false
    assert_equal string_uniq_faster?(duplicate2), false
  end
end
