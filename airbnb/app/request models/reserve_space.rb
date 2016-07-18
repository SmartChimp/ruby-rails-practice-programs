class ReserveSpace
	attr_accessor :from, :to, :space_id, :user_id, :no_of_guests, :city_id, :room_type, :space_max_guests_count

	def initialize(args)
		@from = Date.strptime(args["from"], '%m/%d/%Y')
		@to = Date.strptime(args["to"], '%m/%d/%Y')
		@space_id = args["space_id"]
    @no_of_guests = args["guests_count"]
	end
end