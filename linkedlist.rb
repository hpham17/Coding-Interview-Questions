require 'set'
require 'pp'

class LinkedList
  attr_accessor :next, :data
  def initialize(num)
    @next = nil
    @data = num
  end

  def append(num)
    child = self
    while child.next != nil do
      child = child.next
    end
    child.next = LinkedList.new(num)
  end

  def delete(num)
    copy = self
    return self.next if copy.data == num
    while (copy.next != nil) do
      if copy.next.data = num
        copy.next = copy.next.next
        return self
      end
      copy = copy.next
    end
  end
end

@list = LinkedList.new(9)
@list.append(3)
@list.append(4)
puts @list.data
puts @list.next.data
puts @list.next.next.data
@list = @list.delete(9)
puts @list.data


# 2.1 Write code to remove duplicates from an unsorted linked list.
# FOLLOW UP
# How would you solve this problem if a temporary buffer is not allowed?

# 5 > 5 > 3 > 2 > 5

def remove_dup(linked)
  dups = Set.new
  remove = []
  copy = linked
  while (copy != nil)
    if dups.include? copy.data
      remove << copy.data
    else
      dups.add copy.data
    end
    copy = copy.next
  end
  p remove
  i = 0
  while i < remove.size do
    linked = linked.delete(remove[i])
    i += 1
  end
  return linked
end

@new = LinkedList.new 5
@new.append 5
@new.append 3
@new.append 2
@new.append 5
@new = remove_dup @new

3.times do
  puts @new.data
  @new = @new.next
end


# 2.2 Implement an algorithm to find the nth to last element of a singly linked list.
class LinkedList
  # returns # of datas
  def count
    count = 0
    copy = self
    while (copy != nil) do
      count += 1
      copy = copy.next
    end
    return count
  end

  # assuming first to last is the last LinkedList and n is (1..self.size)
  def find_nth(n)
    count = self.count
    copy = self
    count -= n
    while count > 0 do
      copy = copy.next
      count -= 1
    end
    return copy
  end
end

@new = LinkedList.new 9
@new.append 4
@new.append 4
@new.append 3
@new.append 5
puts @new.count
puts "Traverse backwards!"
puts @new.find_nth(1).data
puts @new.find_nth(2).data
puts @new.find_nth(3).data
puts @new.find_nth(4).data
puts @new.find_nth(5).data

# 2.4 You have two numbers represented by a linked list, where each node contains a single digit. The digits are stored in reverse order, such that the 1’s digit is at the head of the list. Write a function that adds the two numbers and returns the sum as a linked list.
# EXAMPLE
# Input: (3 -> 1 -> 5) + (5 -> 9 -> 2)
# Output: 8 -> 0 -> 8

list1 = LinkedList.new 3
list1.append 1
list1.append 5
list2 = LinkedList.new 5
list2.append 9
list2.append 2

def add(lst1, lst2)
  sum = 0
  carry = 0
  sum = lst1.data+lst2.data
  if sum >= 10
    sum -= 10
    carry = 1
  end
  new_list = LinkedList.new sum
  copy1 = lst1.next
  copy2 = lst2.next
  while copy1 != nil do
    sum = copy1.data + copy2.data + carry
    carry = 0
    if sum >= 10
      sum -= 10
      carry = 1
    end
    new_list.append sum
    copy1 = copy1.next
    copy2 = copy2.next
  end
  return new_list
end

new_list = add(list1, list2)
while new_list != nil do
  puts new_list.data
  new_list = new_list.next
end


# 2.5 Given a circular linked list, implement an algorithm which returns node at the beginning of the loop.
# DEFINITION
# Circular linked list: A (corrupt) linked list in which a node’s next pointer points to an earlier node, so as to make a loop in the linked list.
# EXAMPLE
# input: A -> B -> C -> D -> E -> C [the same C as earlier]
# output: C
