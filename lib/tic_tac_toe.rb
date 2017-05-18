class TicTacToe
  def initialize(board = nil)
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], # Bottom row
    [0,3,6], # Left column
    [1,4,7], # Middle column
    [2,5,8], # Right column
    [0,4,8], # Left diagonal
    [2,4,6]  # Right diagonal
  ]

  def display_board()
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, value = "X")
    @board[index] = value
  end

  def position_taken?(index)
    @board[index] != " " && @board[index] != ""
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn()
    puts "Please enter 1-9:"
    input = gets.chomp
    index = input_to_index(input)
    if valid_move?(index) == true
      move(index, current_player())
      display_board()
    else
      turn()
    end
  end

  def turn_count()
    @board.count {|token| token == "X" || token == "O"}
  end

  def current_player()
    @board.each do |space|
      if turn_count() % 2 == 0
        return "X"
      else
        return "O"
      end
    end
  end

  def won?() #Has the game been won?
    WIN_COMBINATIONS.each do |win_combination| #iterates through each combination
      if (@board[win_combination[0]] == "X" && @board[win_combination[1]] == "X" && @board[win_combination[2]] == "X") || #checks for X
         (@board[win_combination[0]] == "O" && @board[win_combination[1]] == "O" && @board[win_combination[2]] == "O")    #checks for O
         return win_combination #returns the win_combination indexes that won.
      end
    end
     return false
  end

  def full?() #Is the board full?
      if @board.include?(" ")
        return false
      end
        return true
  end

  def draw?()
    if won?() == false && full?() == true
      return true
    else
      return false
    end
  end

  def over?() #Is the game over?
      if full? != false && (won? != false || draw? != false)
        return true
      else
        return false
      end
  end

  def winner() #Who is the winner?
      if won? != false #Because TRUE "won?(board)" returns win_combination.
        return @board[won?[0]] #Will return either X or O depending on who won.
      end
      return nil
  end

  def play()
    until over? || won? || draw?
      turn()
    end

    if winner == "X" || winner == "O"
      puts "Congratulations #{winner()}!"
    else
      if draw?()
        puts "Cat's Game!"
      end
    end
  end

end
