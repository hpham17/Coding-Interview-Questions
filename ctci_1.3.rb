#1.3 Design an algorithm and write code to remove the duplicate characters in a string without using any additional buffer. Note: One or two additional variables are fine. An extra copy of the array is not.
#FOLLOW UP
#Write the test cases for this method.


def remove_duplicates(str)
    check = 0b0
    remove = []
    str.each_char.with_index do |c, index|
      one = 0b1
      if (check ^ one << (c.ord - 97)) < check
          remove << index
      else
        check = check ^ one << (c.ord - 97)
      end
    end
    remove.sort!
    number_deleted = 0
    remove.each do |r|
      str.slice!(r-number_deleted)
      number_deleted += 1
    end if remove
    return str
end

string1 = "abca"
string2 = "aaaa"
string3 = "abbbababc"
puts remove_duplicates string3
