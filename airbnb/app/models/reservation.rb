class Reservation < ActiveRecord::Base
  attr_accessible :from_date, :to_date, :user_id, :space_id, :space, 
  :no_of_guests, :city_id, :room_type

  scope :get_reserved_spaces_by_user, lambda { |user_id| {
      :conditions => ["user_id = ?", user_id]
    } 
  }

  scope :get_reservation_between_days, lambda { |search| 
      where("city_id = :city_id 
      AND ( 
            (:from BETWEEN from_date AND to_date)
            OR (:to BETWEEN from_date AND to_date) 
            OR (from_date BETWEEN :from AND :to)
          ) AND room_type != :shared_room_type", 
      { city_id: search.city_id.to_i, from: search.from, to: search.to, shared_room_type: Airbnb::SHARED_ROOM } ).select("space_id, no_of_guests")
  }

  def self.reserve_non_shared_rooms(reserve_space)
    Reservation.where("( :from BETWEEN from_date AND to_date OR :to BETWEEN from_date AND to_date OR from_date BETWEEN :from AND :to ) AND space_id = :space_id", { from: reserve_space.from, to: reserve_space.to, space_id: reserve_space.space_id }).first_or_create do |reservation| 
      reservation.to_date = reserve_space.to
      reservation.from_date = reserve_space.from
      reservation.user_id = reserve_space.user_id
      reservation.space_id = reserve_space.space_id
      reservation.no_of_guests = reserve_space.no_of_guests
      reservation.city_id = reserve_space.city_id
      reservation.room_type = reserve_space.room_type
    end
  end

  belongs_to :space
  belongs_to :user
  
end