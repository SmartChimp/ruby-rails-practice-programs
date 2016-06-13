class HomeController < ApplicationController

	@@games = Array.new

	def new_game
		if(params['name'] != nil && params['name'] != '') 
			cookies[:user_name] = params['name']
			cookies[:who_am_i] = 'player1'

			game = Game.new
			game.set_current_player 'player1'
			game.set_status 'Game Initiated'
			game.add_player params['name']
			game.set_id (@@games.size + 1)
			@@games.push game

			@game_json_text = game.to_json
			render :template => "home/new_game", :layout => false
		else
			render "/"
		end
	end

	def index
		render "index", :layout => 'application'
	end

	helper_method :get_games

	def get_games
		@@games
	end 

	def join_game
		@game = @@games[params['id'].to_i - 1]
		if(@game != nil) 
			cookies[:user_name] = params['name']
			if(@game.get_players_count < 2)
				@game.add_player params['name']
				cookies[:who_am_i] = 'player2'
			else
				@game.add_viewer params['name']
				cookies[:who_am_i] = 'viewer'
			end
			render :template => "home/join_game", :layout => false
		else
			render "/"
		end
	end

	def update_coin
		game_index = params['id'].to_i - 1
		if @@games[game_index] != nil
			@@games[game_index].set_player1_coin params['player1_coin']
			@@games[game_index].set_player2_coin params['player2_coin']
		end
		render nothing: true
	end

	def update_board_state
		game = @@games[params['id'].to_i - 1]
		board_state = params['board_state'].split(',')
		game.set_board_state board_state
		game.set_status params['status']
		game.set_winner params['winner']
		if(params['player'] == 'player1')
			game.set_current_player 'player2'
		else
			game.set_current_player 'player1'
		end
		render nothing: true
	end

	def get_game_data
		render json: @@games[params['id'].to_i - 1]
	end
end
