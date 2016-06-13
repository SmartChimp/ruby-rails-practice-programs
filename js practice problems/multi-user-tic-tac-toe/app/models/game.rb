class Game
  
  def initialize
  	@players = Array.new
  	@viewers = Array.new
    @board_state = Array.new(9) { "" }
  	@player_count = 0
  end

  def set_id(id)
  	@id = id
  end

  def set_winner(winner)
  	@winner = winner
  end

  def set_current_player(player)
  	@current_player = player
  end

  def set_status(status)
  	@status = status
  end

  def increment_player_count
  	@player_count += 1
  end

  def set_player1_coin(coin)
  	@player1_coin = coin
  end

  def set_player2_coin(coin)
  	@player2_coin = coin
  end

  def add_player(player_name)
  	increment_player_count
  	@players.push player_name
  end

  def add_viewer(viewer_name)
  	@viewers.push viewer_name
  end

  def get_id
  	return @id
  end

  def get_winner
  	return @winner
  end

  def get_current_player
  	return @current_player
  end

  def get_status
  	return @status
  end

  def get_players_count
  	return @player_count
  end

  def get_player1_coin
  	return @player1_coin
  end

  def get_player2_coin
  	return @player2_coin
  end

  def get_players
  	return @players
  end

  def get_viewers
  	return @viewers
  end

  def get_board_state
    return @board_state
  end

  def set_board_state(board_state)
    @board_state = board_state
  end  

  def to_json(options = {})
  	return "{ \"id\" : \"#{@id}\", \"winner\"  : \"#{@winner}\", \"current_player\" : \"#{@current_player}\", \"status\" : \"#{@status}\", \"player_count\" : \"#{@player_count}\", \"player1_coin\" : \"#{@player1_coin}\", \"player2_coin\" : \"#{@player2_coin}\", \"players\" : #{@players}, \"viewers\"  : #{@viewers}, \"block_value\" : #{@board_state}}"
  end
end
