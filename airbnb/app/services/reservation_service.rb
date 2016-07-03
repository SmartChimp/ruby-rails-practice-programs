class ReservationService
	include Singleton

	public

	def reserve(reserve_space)
		reservation = Reservation.new 
		reservation.from_date = reserve_space.from
		reservation.to_date = reserve_space.to
		reservation.user_id = reserve_space.user_id
		reservation.space_id = reserve_space.space_id
		
		reservation.save
	end
end