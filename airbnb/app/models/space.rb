class Space < ActiveRecord::Base
  attr_accessible :address, :cost_per_day, :max_guests_count, :bathrooms_count, :beds_count, :city_id, :home_id, :room_id, :user_id, :id

  belongs_to :city
  belongs_to :user
  belongs_to :room
  belongs_to :home
  has_many :reservations
  has_and_belongs_to_many :amenities

end
