class TicTacToe


  def initialize
    @board = [" ", " ", " ", " ", " ", " ",
       " ", " ", " "]
  end

  WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,4,8],
     [2,4,6], [0,3,6], [1,4,7], [2,5,8]]
  # Define display_board that accepts a board and prints
  # out the current state.
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def valid_move?(index)
    if position_taken?(index)
      return false
    elsif !index.between?(0,8)
      return false
    end
    return true
  end

  # code your input_to_index and move method here!
  def input_to_index(input)

    begin
      n = Integer(input)
    rescue ArgumentError
      return -1
    end

    if input.to_i == 0
      return "0".to_i
    end

    return input.to_i - 1
  end

  def move(index, char = "X")
    @board[index] = char
    #display_board(board)
    return @board
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    converted_input = input_to_index(input)

    until valid_move?(converted_input) == true do
      puts "Wrong move. Please pick the right move."
      input = gets.strip
      converted_input = input_to_index(input)
    end

    move(converted_input, current_player(@board))

    display_board
  end

  def turn_count
    counter = 0

    @board.each do |player|
      if player.strip != ""
        counter += 1
      end
    end

    return counter
  end

  def current_player
    return turn_count(@board).even? ? "X" : "O"
  end

  # Helper Method
  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end


  def won?

     match = @board.size.times.select{|i| @board[i] == "X"}
     match2 = @board.size.times.select{|i| @board[i] == "O"}

     if !@board.include?("X") && !@board.include?("O")
       return nil
     end

     WIN_COMBINATIONS.each do |combo|
       if match & combo == combo || match2 & combo == combo
         return combo
       end
     end

     return false
  end

  def full?
    if(@board.size.times.select{|i| @board[i] == "X" ||@board[i] == "O" }.size == 9)
      return true
    else
      return false
    end
  end

  def draw?
    if full? && !won?
      return true
    elsif !won? && !full?
      return false
    elsif won?
      return false
    end
  end

  def over?
    if draw? || won? || full?
      return true
    else
      return false
    end
  end

  def winner
    if won? == false
      return nil
    end
    return @board[won?[0]]
  end

  def play
    until over?
      turn
    end

    if won?(@board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(@board)
      puts "Cat's Game!"
    end
  end
end
