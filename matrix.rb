require 'pp'
#This question was BuildZoom's interview using Karat.

# Given a matrix find the top-left corner and bottom-right corner or
# find the top-left corner and the width and height of the rectangle
# made of 0's

example = [
[1,1,1,1,1],
[1,1,0,0,0],
[1,1,0,0,0],
[1,1,1,1,1]]

example1 = [
[0,0,1,1,1],
[0,0,1,1,1],
[1,1,1,1,1],
[1,1,1,1,1]]

example2 = [
[0,1,1,1,1],
[1,1,1,1,1],
[1,1,1,1,1],
[1,1,1,1,1]]

example_hard = [
[0,1,1,1,1,1],
[1,1,0,0,0,1],
[1,1,0,0,0,1],
[0,0,1,1,1,1],
[0,0,1,1,1,1]]
#> [[0, 0, 1, 1], [2, 1, 2, 3], [0, 3, 1, 2]]

def find_rectangle(matrix)
  x = 0
  y = 0
  height = 0
  width = 0
  x, y, width = find_top_left_and_width(matrix)
  (y..matrix.size-1).each do |row_index|
    matrix[row_index][x] == 0 ? height += 1 : break
  end
  return [x, y, height, width]
end

def find_top_left_and_width(matrix)
  result = []
  found = false
  width = 0
  matrix.each.with_index do |row, row_index|
    break if found
    row.each.with_index do |column, column_index|
      if !found
        if column == 0
          result += [column_index, row_index]
          found = true
          width += 1
        end
      else
        column == 0 ? width += 1 : break
      end
    end
  end
  result << width
end

puts find_rectangle example2

# Part 2
# Harder: find all rectangles
# Approach: A top-left corner is defined as having non-zero top and left neighbors

def find_all_top_lefts(matrix)
  corners = []
  matrix.each.with_index do |row, row_index|
    row.each.with_index do |column, column_index|
      # checks if top and left neighbor is not 0
      if row_index == 0
        if column_index == 0 && column == 0
          corners << [column_index, row_index]
        elsif (matrix[0][column_index-1] != 0 && column == 0)
          corners << [column_index, row_index]
        end
      elsif (matrix[row_index-1][column_index] != 0) && (matrix[row_index][column_index-1] != 0) && (column == 0)
        corners << [column_index, row_index]
      end
    end
  end
  return corners
end

def find_width(matrix, corner)
  x, y = corner
  row = matrix[y]
  width = 0
  (x..matrix[0].size-1).each do |num|
    matrix[y][num] == 0 ? width += 1 : break
  end
  width
end

def find_height(matrix, corner)
  x, y = corner
  height = 0
  (y..matrix.size-1).each do |row|
    matrix[row][x] == 0 ? height += 1 : break
  end
  height
end

def find_rectangles(matrix, corners)
  rectangles = []
  corners.each do |corner|
    x, y = corner
    width = find_width(matrix, corner)
    height = find_height(matrix, corner)
    rectangles << [x, y, height, width]
  end
  rectangles
end

corners = find_all_top_lefts(example_hard)
p find_rectangles(example_hard, corners)
