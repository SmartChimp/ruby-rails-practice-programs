class ReservationService
	include Singleton

	public

	def reserve(reserve_space)
		result = 0
		ActiveRecord::Base.transaction do
			Reservation.connection.execute("INSERT INTO reservations(to_date, from_date, user_id, space_id, created_at, updated_at) \
				SELECT date('#{reserve_space.to}'), date('#{reserve_space.from}'), #{reserve_space.user_id}, #{reserve_space.space_id}, \
				datetime('now'), datetime('now') WHERE (SELECT count(id) \
				FROM reservations r \
				WHERE (( \
							date('#{reserve_space.from}') >= r.from_date \
							AND date('#{reserve_space.from}') <= r.to_date \
							) \
						OR ( \
							date('#{reserve_space.to}') >= r.from_date \
							AND date('#{reserve_space.to}') <= r.to_date \
							) \
						OR ( \
							r.from_date > date('#{reserve_space.from}') \
							AND r.from_date < date('#{reserve_space.from}') \
							) \
						) AND r.space_id = #{reserve_space.space_id}) = 0")
			result = Reservation.count('id', :conditions => ["from_date = ? AND to_date = ? AND space_id = ? AND user_id = ?",reserve_space.from, reserve_space.to, reserve_space.space_id, reserve_space.user_id])
		end
		result
	end

	def get_reserved_spaces_by_user(user_id)
		Reservation.find(:all, :conditions => ["user_id = ?", user_id.to_s])
	end 
end