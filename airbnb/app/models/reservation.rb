class Reservation < ActiveRecord::Base
  attr_accessible :from_date, :to_date, :user_id, :space_id, :space, 
  :no_of_guests, :city_id, :room_type

  scope :get_reserved_spaces_by_user, lambda { |user_id| {
      :conditions => ["user_id = ?", user_id]
    } 
  }

  def self.reserve(reserve_space)
    Reservation.where("((
              :from >= from_date
              AND :from <= to_date
              )
            OR ( 
              :to >= from_date
              AND :to <= to_date 
              ) 
            OR ( 
              from_date > :from
              AND from_date < :from
              ) 
            ) AND space_id = :space_id", { from: reserve_space.from, to: reserve_space.to, space_id: reserve_space.space_id }).first_or_create do |reservation| 
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