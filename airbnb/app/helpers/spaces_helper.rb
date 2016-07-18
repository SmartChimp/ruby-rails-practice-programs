module SpacesHelper
	module ConstructJSONResponse
		def self.for_cities_like(cities)
			response_txt = "["
			cities.each do |city|
				response_txt += " { \"id\" : \"#{city.id}\", \"value\" : \"#{city.name}\", \"label\": \"#{city.name}\" },"
			end
			response_txt.chop + " ]"
		end

		def self.for_space_search(spaces)
			response_txt = '{'
			spaces.each do |space|
				response_txt += ""
			end
		end
	end

end
