require 'pp'

# This was the free "redo" attempt for Karat

employees = [
  "1, Bill, Engineer",
  "2, Joe, HR",
  "3, Sally, Engineer",
  "4, Richard, Business",
  "6, Tom, Engineer"
]

friendships = [
  "1, 2",
  "1, 3",
  "3, 4"
]
# Part 1 :
# Given employees and friendships, find all adjacencies that denote the friendship
# A friendship is bi-directional/mutual so if 1 is friends with 2, 2 is also friends with 1.
# Output:
# 1: 2, 3
# 2: 1
# 3: 1, 4
# 4: 3
# 6: None

def adjacencies(friendships, employees)
  adjacencies = Hash.new { Array.new }
  friendships.each do |f|
    ids = f.split(",")
    ids.map!(&:to_i)
    adjacencies[ids[0]] = adjacencies[ids[0]] << ids[1]
    adjacencies[ids[1]] = adjacencies[ids[1]] << ids[0]
  end
  ids = []
  employees.each do |e|
    string = e.split ","
    ids << string[0].to_i
  end
  ids.each do |id|
    if !adjacencies.include?(id)
      adjacencies[id] = []
    end
  end
  p adjacencies
end

adjacencies(friendships, employees)

# Part 2:
# Now for each department count the number of employees that have a friend in
# another department
# Output:
# "Engineer: 2 of 3"
# "HR: 1 of 1"
# "Business: 1 of 1"

# Interviewer modified friendship so that 6 has a friend.
friendships2 = [
  "1, 2",
  "1, 3",
  "3, 4",
  "6, 1"
]

# all_departments = {"Engineer": [0,3]}

def department_count(friendships, employees)
  # All unique department counts
  all_departments = Hash.new { Array.new(2){0} }
  # Maps each id to their respective department
  id_to_department = {}
  adjacencies = adjacencies(friendships, employees)
  employees.each do |e|
    employee = e.split(",")
    id_to_department[employee[0].to_i] = employee[2]
    all_departments[employee[2]] = [0, 0] if !all_departments.include? employee[2]
    all_departments[employee[2]][1] += 1
  end
  all_departments.each do |department|
    ids = id_to_department.select{|k,v| v == department[0] }.keys
    ids.each do |id|
      if adjacencies[id].any?{ |i| id_to_department[i] != id_to_department[id] }
        all_departments[department[0]][0] += 1
      end
    end
  end
  p all_departments
end

department_count(friendships2, employees)
