class ReservationService
  include Singleton

  def reserve(reserve_space)
    is_space_reserved = false;
    space = Space.find_by_id(reserve_space.space_id)
    if(space != nil)
      reserve_space.room_type = space.room_type
      reserve_space.city_id = space.city_id
      reserve_space.space_max_guests_count = space.max_guests_count
      reserved_space = Reservation.reserve(reserve_space)
      if(reserved_space.user_id == reserved_space.user_id && reserved_space.from_date == reserve_space.from && reserved_space.to_date == reserve_space.to)
        is_space_reserved = true
      end
    end
    return is_space_reserved
  end
  
end
