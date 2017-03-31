require 'pp'
class TicTacToe
  attr_accessor :board
  attr_accessor :you
  # init empty board nil means nothing there
  # [ 6 7 8 ]
  # [ 3 4 5 ]
  # [ 0 1 2 ]
  # player is either 'x' or 'o'
  # x always goes first
  def initialize(turn)
    @board = Array.new(9)
    @win = [[0,1,2], [3,4,5], [6,7,8],
            [0,3,6], [1,4,7], [2,5,8],
            [0,4,8], [2,4,6]]
    @you = turn
    @turn = turn
    # comp goes first
    if turn == 'o'
      changeTurn
      self.randomComputer
      changeTurn
    end
  end

  def changeTurn
    @turn == 'x' ? @turn = 'o' : @turn = 'x'
  end

  # computer randomly takes available turn
  def randomComputer
    @available = []
    @board.each.with_index { |b, index| @available << index if b == nil }
    @board[@available.sample] = @turn
  end

  def smartComputer
    # try to block from winning
    @win.each do |row|
      count = 0
      empty_index = 0
      row.each do |r|
        if @board[r] == @you
          count += 1
        else
          empty_index = r
        end
      end
      if count == 2
        @board[empty_index] = @turn
        return
      end
    end
    # else try to win
    randomComputer
  end

  def available_moves
    @available = []
    @board.each.with_index { |b, index| @available << index if b == nil }
    @available
  end

  # checks if you entered valid move
  def checkValid(x)
    !@board[x] && (0..8).include?(x)
  end

  def takeAction(x)
    @board[x] = @turn
  end

  # end game conditions
  def isOver?
    if (isWin? || tie?)
      true
    else
      changeTurn
      false
    end
  end

  def isWin?
    @win.any? { |row| row.all? { |pos| @board[pos] == @turn }}
  end

  def tie?
    @board.all? { |x| x != nil }
  end

  def winner?
    if isWin?
      @turn == @you ? puts("You win!! :)") : puts("You lose. :(")
    else
      puts "Dun dun dun. Play again to break the tie!"
    end
  end

  # Game GUI
  def printBoard
    board = @board.each_slice(3).to_a.reverse
    board.each { |row| pp row }
  end

  # Dummy instructional board
  def printPositionBoard
    board = (0..8).to_a.each_slice(3).to_a.reverse
    board.each { |row| pp row }
  end
end


# MAIN: starts and plays game
puts "Welcome to TicTacToe!"
puts "Player 'x' always goes first"
puts "Please choose to be 'x' or 'o'."

player = gets.chomp
while((player != 'x' && player != 'o')) do
  puts "Please enter 'x' or 'o'"
  player = gets.chomp
end
@game = TicTacToe.new(player)

puts "Here is what the board will look like."
@game.printPositionBoard

puts "You will need to remember this and input the number corresponding
 to where you want take your turn."

while (true) do
  puts "Current board:"
  @game.printBoard
  puts "You are player: #{@game.you}"
  puts "Available moves: #{@game.available_moves}"
  puts "Please choose a spot! (from 0 to 8)"
  pos = gets.chomp.to_i
  if @game.checkValid(pos)
     @game.takeAction(pos)
  else
    puts "Invalid move. Please try again."
    next
  end
  break if @game.isOver?
  @game.smartComputer
  break if @game.isOver?
  puts " "
end
@game.winner?
puts "Thank you for playing!"
