class CityService
	include Singleton

	public

	def get_cities_like(q)
		City.find_by_sql ["SELECT id, name FROM cities WHERE name LIKE ? LIMIT 10", "#{q}%"]
	end

end