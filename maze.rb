# Maze.rb
# Maze program to tell the possibilities.

class Maze

	def initialize(maze)
		maze_collection = maze.split(patern ="\n")
		@maze_hash = Hash.new
		no_of_rows = 0
		no_of_columns = 0

		@starting_index_of_row = 0
		@starting_index_of_column = 0

		maze_collection.each do |value|
			no_of_columns = 0 
			value.each_char do |ch|
				key = "["+no_of_rows.to_s+","+no_of_columns.to_s+"]" 
				@maze_hash[key] = ch
				if ch == 'A'
					@starting_index_of_row = no_of_rows
					@starting_index_of_column = no_of_columns
				end
				no_of_columns+=1
			end
			no_of_rows+=1
		end
	end

	def get_top(row_index, column_index) 
		row_to_check = row_index - 1 
		@maze_hash["["+row_to_check.to_s+","+column_index.to_s+"]"]
	end

	def get_down(row_index, column_index) 
		row_to_check = row_index + 1
		@maze_hash["["+row_to_check.to_s+","+column_index.to_s+"]"]
	end

	def get_right(row_index, column_index) 
		column_to_check = column_index+1
		@maze_hash["["+row_index.to_s+","+column_to_check.to_s+"]"]
	end

	def get_left(row_index, column_index) 
		column_to_check = column_index-1
		@maze_hash["["+row_index.to_s+","+column_to_check.to_s+"]"]
	end

	def move_left(row_index, column_index)
		left_value = get_left  row_index, column_index
		if(left_value == "B")  
			return true
		elsif(left_value == " ")
			return_value = move_left row_index, column_index-1
			if return_value
				return true
			else
				return move_top_or_down row_index, column_index
			end
		elsif(left_value == "#")
			return move_top_or_down row_index, column_index 
		else
			return false
		end
	end

	def move_top_or_down(row_index, column_index)
		top_value = get_top row_index, column_index
		if(top_value == "B")  
			return true
		elsif(top_value == " ")
			return_value = move_up(row_index-1, column_index)
			if return_value
				return true
			else
				return go_down row_index, column_index
			end
		elsif(top_value == "#")
			return go_down row_index, column_index
		else
			return false
		end
	end

	def go_down(row_index, column_index)
		bottom_value = get_down row_index, column_index
		if(bottom_value == "B")  
			return true
		elsif(bottom_value == " ")
			return move_down(row_index+1, column_index)
		else
			return false
		end
	end

	def move_down(row_index, column_index) 
		bottom_value = get_down row_index, column_index
		if(bottom_value == 'B')  
			return true
		elsif(bottom_value == " ") 
			return_value = move_down row_index+1, column_index
			if return_value
				return true
			else
				return move_left_or_right row_index, column_index
			end
		elsif(bottom_value == "#") 
			return move_left_or_right row_index, column_index
		else
			return false
		end
	end

	def move_left_or_right(row_index, column_index)
		left_value = get_left row_index, column_index
		if(left_value == "B")
			return true
		elsif(left_value == " ")
			return_value = move_left row_index, column_index-1
			if return_value
				return true
			else
				return go_right row_index, column_index
			end
		elsif(left_value == "#")
			return go_right row_index, column_index
		else
			return false
		end	
	end

	def go_right(row_index, column_index)
		right_value = get_right row_index, column_index
		if(right_value == "B")
			return true
		elsif(right_value == " ")
			return move_right row_index, column_index+1
		else
			return false
		end
	end

	def move_up(row_index, column_index) 
		up_value = get_top row_index, column_index
		if(up_value == 'B')  
			return true
		elsif(up_value == " ") 
			return_value = move_up(row_index-1, column_index)
			if return_value
				return true
			else
				return move_left_or_right row_index, column_index
			end
		elsif(up_value == "#") 
			return move_left_or_right row_index, column_index
		else
			return false
		end
	end

	def move_right(row_index, column_index) 
		right_value = get_right row_index, column_index
		if(right_value == 'B')  
			return true
		elsif(right_value == " ") 
			return_value = move_right(row_index, column_index+1)
			if return_value
				return true
			else
				return move_top_or_down row_index, column_index 
			end
		elsif(right_value == "#") 
			return move_top_or_down row_index, column_index 
		else
			return false
		end
	end

	def solvable?
		if get_top(@starting_index_of_row, @starting_index_of_column) == ' ' && move_up(@starting_index_of_row, @starting_index_of_column)
			return true
		end
		if get_right(@starting_index_of_row, @starting_index_of_column) == ' ' && move_right(@starting_index_of_row, @starting_index_of_column)
			return true
		end
		if get_left(@starting_index_of_row, @starting_index_of_column) == ' ' && move_left(@starting_index_of_row, @starting_index_of_column)
			return true
		end
		if get_down(@starting_index_of_row, @starting_index_of_column) == ' ' && move_down(@starting_index_of_row, @starting_index_of_column)
			return true
		end
		return false
	end
end