json.spaces @spaces do |space|
	json.id space.id
	json.address space.address
	json.city space.city.name
	json.cost_per_day space.cost_per_day
	json.no_of_bathrooms space.bathrooms_count
	json.no_of_beds space.beds_count
	json.home_type space.home.home_type
	json.room_type space.room.room_type
	json.user do 
		json.id space.user.id
		json.fristname space.user.firstname
		json.lastname space.user.lastname
 	end
end
