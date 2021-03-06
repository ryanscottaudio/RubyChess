class Game
  attr_accessor :board, :player_white, :player_black, :current_player, :cursor

  def initialize(name1, name2)
    @board = Board.new
    @player_white = HumanPlayer.new(name1, :white)
    @player_black = HumanPlayer.new(name2, :black)
    @current_player = player_white
    @cursor = [7, 7]
    play
  end

  def switch_players
    if current_player == player_white
      self.current_player = player_black
    else
      self.current_player = player_white
    end
  end

  def play
    until won?
      play_turn
    end
    declare_winner
  end

  def play_turn
    selected = nil;
    board.render(cursor, selected, current_player.color)
    puts "#{current_player.name}'s turn!"

    begin
      current_player.prompt("starting")
      starting_pos = move_cursor.dup
      board.checkColor(current_player.color, starting_pos)
    rescue MoveError => e
      puts e.message
      retry
    end

    selected = starting_pos

    begin
      current_player.prompt("ending")
      ending_pos = move_cursor(selected).dup
      if starting_pos == ending_pos
        self.play_turn
        return
      end
      board.move(current_player.color, starting_pos, ending_pos)
    rescue MoveError => e
      puts e.message
      retry
    end

    switch_players
  end

  def move_cursor(selected = nil)
    keystroke = ""
    until keystroke == "\r" || keystroke == " "
      keystroke = current_player.get_move
      action(keystroke)
      self.check_cursor
      board.render(cursor, selected, current_player.color)
    end

    cursor
  end

  def action(char)
    case char
    when "\e[A"
      if current_player.color == :white
        cursor_up
      else
        cursor_down
      end
    when "\e[B"
      if current_player.color == :white
        cursor_down
      else
        cursor_up
      end
    when "\e[C"
      if current_player.color == :white
        cursor_right
      else
        cursor_left
      end
    when "\e[D"
      if current_player.color == :white
        cursor_left
      else
        cursor_right
      end
    when "\r"
      nil
    when " "
      nil
    when "S"
      save_game
    when "L"
      load_game
    when "F" && !board[board.cursor].revealed
      board[board.cursor].flagged ? board[board.cursor].switch_flag : reveal_pos(pos)
    when "R" && !board[board.cursor].revealed && !board[board.cursor].flagged
      reveal_pos(board[board.cursor])
    end
  end

  def cursor_up
    self.cursor[0] -= 1
  end

  def cursor_down
    self.cursor[0] += 1
  end

  def cursor_left
    self.cursor[1] -= 1
  end

  def cursor_right
    self.cursor[1] += 1
  end

  def check_cursor
    self.cursor.map! do |coord|
      coord = Board::SIZE - 1 if coord >= Board::SIZE
      coord = 0 if coord < 0
      coord
    end
  end

  def declare_winner
    switch_players
    puts "#{current_player.name} wins!"
  end

  def won?
    board.checkmate?(current_player.color)
  end
end
