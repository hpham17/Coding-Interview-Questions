# 1.4 Write a method to decide if two strings are anagrams or not.

s1 = "banana"
s2 = "ananab"
s3 = "abaanna"
s4 = "banaaa"

# time complexity of 2n space complexity of n
def is_anagram?(str1, str2)
  return false if str1.size != str2.size
  first = Hash.new(0)
  str1.each_char do |c|
    first[c] += 1
  end
  str2.each_char do |s|
    if first[s] > 0
       first[s] -= 1
    else
       return false
    end
  end
  true
end


puts is_anagram?(s1, s2)
puts is_anagram?(s5, s6)
