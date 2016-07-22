class ReservationService
  include Singleton

  def reserve(reserve_space)
    is_space_reserved = false;
    space = Space.find_by_id(reserve_space.space_id)
    if(space != nil)
      reserve_space.room_type = space.room_type
      reserve_space.city_id = space.city_id

      if(space.room_type == Airbnb::SHARED_ROOM) 
        return is_space_reserved if !ReservedGuest.increment_guests_count(reserve_space.from, reserve_space.to, reserve_space.space_id, reserve_space.no_of_guests, space.max_guests_count)
        Reservation.new(from_date: reserve_space.from, to_date: reserve_space.to, user_id: reserve_space.user_id, space_id: reserve_space.space_id, no_of_guests: reserve_space.no_of_guests, city_id: reserve_space.city_id, room_type: reserve_space.room_type).save
        is_space_reserved = true;
      else
        reserved_space = Reservation.reserve_non_shared_rooms(reserve_space)
        if reserved_space.user_id == reserve_space.user_id
          is_space_reserved = true
        end  
      end
    end
    is_space_reserved
  end
  
end
