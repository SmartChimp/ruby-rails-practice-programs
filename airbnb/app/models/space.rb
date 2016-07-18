class Space < ActiveRecord::Base
	include ActiveModel::Validations
  attr_accessible :address, :cost_per_day, :max_guests_count, :bathrooms_count, :beds_count, :city_id, :home_type, :room_type, :user_id, :id
  
  scope :search_for_spaces, lambda { |search| 
    joins("LEFT JOIN (", Reservation.select("space_id, no_of_guests").where("city_id = :city_id 
      AND ( 
            (:from >= from_date AND :from <= to_date)
            OR (:to >= from_date AND :to <= to_date) 
            OR (from_date > :from AND from_date < :to)
          )", 
      { city_id: search.city_id.to_i, from: search.from, to: search.to } ).to_sql,
    ") subquery ON subquery.space_id = spaces.id").where("spaces.city_id = :city_id AND subquery.space_id IS NULL", 
      { city_id: search.city_id.to_i })
  }

  scope :get_all_spaces_for_user, lambda { |user_id| {
      :conditions => { user_id: user_id }
    }
  }

  belongs_to :city
  belongs_to :user
  has_many :reservations
  has_and_belongs_to_many :amenities

  validates_with SpaceValidator 

end
