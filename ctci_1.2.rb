# 1.2 Reverse a string

string1 = "monster"
string2 = "a"
string3 = "abc"

def reverse(str)
  first = 0
  last = str.size-1
  while first < last do
    temp = str[first]
    str[first] = str[last]
    str[last] = temp
    first += 1
    last -= 1
  end
  str
end

puts reverse(string1)
puts reverse(string2)
puts reverse(string3)
