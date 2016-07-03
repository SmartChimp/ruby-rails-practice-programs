class SpaceService

	include Singleton

	public

	def get_all_spaces_for_user(user_id)
		Space.find(:all, :conditions => { user_id: user_id })
	end

	def search_for_spaces(search)
		from_date = search.from.strftime('%Y-%m-%d');
		to_date = search.to.strftime('%Y-%m-%d');
		Space.find_by_sql ["SELECT outer.* FROM spaces as outer LEFT JOIN (SELECT s.id as id FROM \
			spaces s JOIN reservations r ON r.space_id = s.id WHERE s.city_id = ? AND \
			((? >= r.from_date AND ? <= r.to_date) OR ( ? >= r.from_date AND ? <= r.to_date) OR \
			(r.from_date > ? AND r.from_date < ?) )) as inner \
			ON outer.id = inner.id WHERE outer.city_id = ? AND inner.id IS NULL", search.city_id, search.from, search.from, search.to, search.to, search.from, search.to, search.city_id]
	end

end