class Search
	attr_accessor :city_id, :from, :to, :guests_count

	def initialize(args)
		@city_id = args["city_id"]
		@from = Date.strptime(args["from"], '%m/%d/%Y')
		@to = Date.strptime(args["to"], '%m/%d/%Y')
		@guests_count = args["guests_count"]
	end
	
end