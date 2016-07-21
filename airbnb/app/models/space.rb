class Space < ActiveRecord::Base
	include ActiveModel::Validations
  attr_accessible :address, :cost_per_day, :max_guests_count, :bathrooms_count, :beds_count, :city_id, :home_type, :room_type, :user_id, :id, :maximum_reserved_guests_count
  
  scope :search_for_spaces, lambda { |search| 
    joins("LEFT JOIN (", Reservation.get_reservation_between_days(search).to_sql,
    ") subquery ON subquery.space_id = spaces.id").where("spaces.city_id = :city_id AND subquery.space_id IS NULL AND spaces.room_type != :shared_room_type AND spaces.max_guests_count >= :max_guests_count", 
      { city_id: search.city_id.to_i, shared_room_type: Airbnb::SHARED_ROOM, max_guests_count: search.guests_count})
  }

  scope :get_all_spaces_for_user, lambda { |user_id| {
      :conditions => { user_id: user_id }
    }
  }

  scope :search_for_shared_room_types, lambda { |search|
    joins("LEFT JOIN reserved_guests ON spaces.id = reserved_guests.space_id AND reserved_guests.calendar_date BETWEEN '#{search.from}'
      AND '#{search.to}' ")
    .where("spaces.city_id = ? AND spaces.room_type = ? AND spaces.max_guests_count >= ? ", search.city_id, Airbnb::SHARED_ROOM, search.guests_count)
    .select("spaces.*, MAX(reserved_guests.guests_count) AS maximum_reserved_guests_count")
    .group("spaces.id")
    .having("maximum_reserved_guests_count is null or maximum_reserved_guests_count <= (spaces.max_guests_count - ?) ", search.guests_count)
  } 

  belongs_to :city
  belongs_to :user
  has_many :reservations
  has_and_belongs_to_many :amenities

  validates_with SpaceValidator 

end
